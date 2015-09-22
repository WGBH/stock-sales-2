class Collection < Cmless
  ROOT = File.expand_path('../views/collections', File.dirname(__FILE__))
  attr_reader :head_html
  attr_reader :short_html
  attr_reader :long_html
  attr_reader :links_html
  attr_reader :grid_html

  private
  
  def img_src(alt)
    Nokogiri::HTML(head_html).xpath("//img[@alt='#{alt}']/@src").first.tap do |optional|
      if optional
        return optional.text
      else
        return nil
      end
    end
  end
  
  public
  
  def thumb_src
    @thumb_src ||= img_src('thumb')
  end
  
  def splash_src
    @splash_src ||= img_src('splash')
  end
  
  def logo_src
    @logo_src ||= img_src('logo')
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