require 'singleton'
require 'nokogiri'
require 'json'
require 'sony-ci-api'
require_relative '../../app/models/asset'
require_relative 'log_roller'

class Converter
  include Enumerable
  include LogRoller
  
  def initialize(xml, cache_path = '/tmp/thumb-src-cache.json')
    @doc = Nokogiri::XML(xml).remove_namespaces!
    @cache_path = cache_path
    refresh_thumb_src_cache()
  end
  
  def each(&block)
    @doc.xpath('/FMPDSORESULT/ROW').each do |record|
      # Reparsing every subelement isn't efficient, 
      # but it lets methods operate on strings, which
      # makes testing easier.
      block.call(to_asset(record.to_xml))
    end
  end
  
  private
  
  def to_asset(xml)
    doc = Nokogiri::XML(xml)
    Asset.new(
      begin
        hash = Hash[ doc.xpath('/ROW/*').map { |el| 
          [el.name.downcase, el.text]
        } ]
        hash.merge({'thumb_src' => @ci_id_to_thumb_src[hash['ci_id']]})
      end
    )
  end
  
  def refresh_thumb_src_cache()
    @ci_id_to_thumb_src = JSON.parse(File.read(@cache_path)) rescue {}
    $LOG.info("Thumb cache starting with #{@ci_id_to_thumb_src.count} entries")
    
    ci_ids_todo = @doc.xpath('/FMPDSORESULT/ROW/Ci_ID')
                 .map(&:text).map(&:strip).reject(&:empty?) - @ci_id_to_thumb_src.keys
    
    if !ci_ids_todo.empty?
      ci = SonyCiAdmin.new(credentials_path: 'config/ci.yml')
      while !ci_ids_todo.empty?
        group = ci_ids_todo.shift(500) # Max dictated by the Sony API
        $LOG.info("#{ci_ids_todo.count} Ci IDs still need details")
        details = ci.multi_details(group, ['thumbnails'])
        @ci_id_to_thumb_src.merge!(Hash[
          details['items'].map { |item| [
            item['id'], 
            item['thumbnails'].select { |thumbnail| 
              thumbnail['type'] == 'small' 
            }.first['location']
          ] } 
        ] )
      end
      File.write(@cache_path, JSON.pretty_generate(@ci_id_to_thumb_src))
    end
  end
  
end
