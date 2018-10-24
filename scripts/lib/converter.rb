require 'singleton'
require 'nokogiri'
require 'json'
require 'sony_ci_api'
require_relative '../../app/models/solr_document'
require_relative 'global_ingest_log'

class Converter
  include Enumerable

  def initialize(xml, cache_path = '/tmp/stock-sales-cache.json')
    @doc = Nokogiri::XML(xml).remove_namespaces!
    @cache_path = cache_path
    refresh_cache()
  end

  def each(&block)
    @doc.xpath('/FMPDSORESULT/ROW').each do |record|
      # Reparsing every subelement isn't efficient,
      # but it lets methods operate on strings, which
      # makes testing easier.
      begin
        block.call(to_solr_record(record.to_xml))
      rescue => e
        $LOG.error("#{e} on:\n #{record.to_xml}")
      end
    end
  end

  private

  THUMBNAILS = 'thumbnails'
  PROXIES = 'proxies'

  def to_solr_record(fm_record_xml)
    SolrDocument.new({
      json:
        begin
          fm_record_doc = Nokogiri::XML(fm_record_xml)
          fm_record_hash = Hash[ fm_record_doc.xpath('/ROW/*').map { |el|
            [el.name.downcase, el.text.strip]
          } ]
          unless fm_record_hash['id']
            fail("No id in #{fm_record_xml}")
          end
          unless fm_record_hash['ci_id']
            fail("No ci_id for FM <#{fm_record_hash['id']}>")
          end
          unless @cache[fm_record_hash['ci_id']]
            fail("No cache for Ci <#{fm_record_hash['ci_id']}> / FM <#{fm_record_hash['id']}>")
          end
          fm_record_hash.merge({
            'thumb_src' => @cache[fm_record_hash['ci_id']][THUMBNAILS].select { |thumbnail|
                  thumbnail['type'] == 'small'
                }.first['location']})
        end.to_json
    })
  end

  def refresh_cache()
    @cache = JSON.parse(File.read(@cache_path)) rescue {}
    $LOG.info("Cache starting with #{@cache.count} entries")

    ci_ids_todo = @doc.xpath('/FMPDSORESULT/ROW/Ci_ID')
                 .map(&:text).map(&:strip).reject(&:empty?) - @cache.keys

    if !ci_ids_todo.empty?
      ci = SonyCiAdmin.new(credentials_path: 'config/ci.yml')
      while !ci_ids_todo.empty?
        group = ci_ids_todo.shift(500) # Max dictated by the Sony API
        $LOG.info("#{ci_ids_todo.count} Ci IDs still need details")
        details = ci.multi_details(group, [THUMBNAILS, PROXIES])
        @cache.merge!(Hash[
          details['items'].map { |item| [
            item['id'],
            {
              THUMBNAILS => item[THUMBNAILS],
              PROXIES => item[PROXIES],
            }
          ] }
        ] )
        File.write(@cache_path, JSON.pretty_generate(@cache))
      end
    end
  end

end
