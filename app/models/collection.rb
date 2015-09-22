class Collection < Cmless
  ROOT = File.expand_path('../views/collections', File.dirname(__FILE__))
  attr_reader :head_html
  attr_reader :short_html
  attr_reader :long_html
  attr_reader :links_html
  attr_reader :grid_html

  def thumb_src
    @thumb_src ||=
      Nokogiri::HTML(head_html).xpath('//img[1]/@src').first.text
  end
  
  def splash_src
    @splash_src ||=
      Nokogiri::HTML(head_html).xpath('//img[2]/@src').first.text
  end
  
  
  def grid_items
    @grid_items ||= begin
      Nokogiri::HTML(grid_html).xpath('//li').map do |li|
        title, subtitle = li.text.split(/\s+\|\s+/)
        OpenStruct.new(
          title: title, 
          subtitle: subtitle, 
          thumbnail_url: li.xpath('img/@src'),
          url: li.xpath('a/@href').text
        )
      end
    end
  end
  
end