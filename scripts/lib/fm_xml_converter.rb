require 'singleton'
require 'nokogiri'
require 'json'

class FmXmlConverter
  include Enumerable
  
  def initialize(xml)
    @doc = Nokogiri::XML(xml).remove_namespaces!
  end
  
  def each(&block)
    @doc.xpath('/FMPDSORESULT/ROW').each do |record|
      # Reparsing every subelement isn't efficient, 
      # but it lets methods operate on strings, which
      # makes testing easier.
      block.call(self.class.convert_record(record.to_xml))
    end
  end
  
  def self.convert_record(xml)
    doc = Nokogiri::XML(xml)
    JSON.pretty_generate(
      Hash[ doc.xpath('/ROW/*').map { |el| 
        [el.name.downcase, el.text]
      } ]
    )
  end
  
end
