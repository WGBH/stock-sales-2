class Legal < Cmless
  ROOT = File.expand_path('../views/legal', File.dirname(__FILE__))
  attr_reader :head_html
  attr_reader :main_html
end