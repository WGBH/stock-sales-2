class Collection < Cmless
  ROOT = File.expand_path('../views/collections', File.dirname(__FILE__))
  attr_reader :grid_html
  attr_reader :head_html
  attr_reader :blurb_html
  
  def thumbnail_url
    @thumbnail_url ||=
      Nokogiri::HTML(head_html).xpath('//img[1]/@src').first.text
  rescue
    'http://placehold.it/272x152'
  end
  
  def order
    @order ||= begin
      i = Nokogiri::HTML(head_html).text.to_i
      i == 0 ? Float::INFINITY : i
    end
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