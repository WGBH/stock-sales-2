require 'singleton'
require 'nokogiri'
require 'json'
require_relative '../../app/models/asset'

class Converter
  include Enumerable
  
  def initialize(xml)
    @doc = Nokogiri::XML(xml).remove_namespaces!
  end
  
  def each(&block)
    @doc.xpath('/FMPDSORESULT/ROW').each do |record|
      # Reparsing every subelement isn't efficient, 
      # but it lets methods operate on strings, which
      # makes testing easier.
      block.call(self.class.to_asset(record.to_xml))
    end
  end
  
  def self.to_asset(xml)
    doc = Nokogiri::XML(xml)
    Asset.new(
      Hash[ doc.xpath('/ROW/*').map { |el| 
        [el.name.downcase, el.text]
      } ]
    )
  end
  
end
