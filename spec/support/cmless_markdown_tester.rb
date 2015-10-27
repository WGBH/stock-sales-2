require 'byebug'

require 'nokogiri'
require 'cmless'
require 'faraday'

class CmlessMarkdownTester

  attr_reader :ng, :path, :markdown, :html

  def initialize(path)
    @path = path
    @markdown = File.read(@path)
    @html = Cmless::Markdowner.instance.render(@markdown)
    @ng = Nokogiri::HTML(@html)
  end

  def broken_urls
    urls.reject{ |url| working_url?(url) }
  end

  def http_status(url)
    Faraday.head(url).status rescue nil
  end

  def working_url?(url)
    http_status(url).to_i.between? 200, 399
  end

  def urls
    hrefs + img_srcs - mailtos
  end

  def img_srcs
    # TODO
    []
  end

  def hrefs
    @hrefs ||= ng.css('a').map { |link| link['href'] }
  end

  def links
    @links ||= (hrefs - mailtos - anchors)
  end

  def external_links
    @external_links ||= links.grep(/^https?\:\/\//)
  end

  def anchors
    @anchors ||= hrefs.grep(/^\#/)
  end

  def mailtos
    @mailto ||= hrefs.grep(/^mailto\:/)
  end

end
