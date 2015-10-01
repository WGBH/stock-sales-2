require 'singleton'
require 'nokogiri'
require 'json'

class FmXmlConverter
  include Singleton
  
  def initialize
    # ???
  end
  
  def convert_record(xml)
    doc = Nokogiri::XML(xml)
    JSON.pretty_generate(
      Hash[ doc.xpath('/ROW/*').map { |el| 
        [el.name.downcase, el.text]
      } ]
    )
  end  
end
