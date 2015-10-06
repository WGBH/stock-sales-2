require 'singleton'
require 'nokogiri'
require 'json'
require 'sony-ci-api'
require_relative '../../app/models/asset'

class Converter
  include Enumerable
  
  def initialize(xml)
    @doc = Nokogiri::XML(xml).remove_namespaces!
    
    @thumbs = {}
    ci = SonyCiAdmin.new(credentials_path: 'config/ci.yml')
    ci_ids = @doc.xpath('/FMPDSORESULT/ROW/Ci_ID').map(&:text).reject(&:empty?)
    while !ci_ids.empty?
      group = ci_ids.shift(500)
      puts "#{ci_ids.count} Ci IDs still need details"
      details = ci.multi_details(group, ['thumbnails'])
      @thumbs.merge(Hash[
        details['items'].map { |item| [
          item['id'], 
          item['thumbnails'].select { |thumbnail| 
            thumbnail['type'] == 'small' 
          }.first['location']
        ] } 
      ] )
    end
  end
  
  def each(&block)
    @doc.xpath('/FMPDSORESULT/ROW').each do |record|
      # Reparsing every subelement isn't efficient, 
      # but it lets methods operate on strings, which
      # makes testing easier.
      block.call(to_asset(record.to_xml))
    end
  end
  
  def to_asset(xml)
    doc = Nokogiri::XML(xml)
    Asset.new(
      begin
        hash = Hash[ doc.xpath('/ROW/*').map { |el| 
          [el.name.downcase, el.text]
        } ]
        hash.merge({'thumb_src' => @thumbs[hash['ci_id']]})
      end
    )
  end
  
end
