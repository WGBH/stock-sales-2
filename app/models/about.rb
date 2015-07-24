class About < Cmless
  ROOT = File.expand_path('../views/about', File.dirname(__FILE__))
  attr_reader :body_html
end