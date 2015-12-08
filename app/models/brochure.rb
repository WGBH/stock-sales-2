class Brochure < Cmless
  ROOT = File.expand_path('../views/brochures', File.dirname(__FILE__))
  attr_reader :body_html  
end