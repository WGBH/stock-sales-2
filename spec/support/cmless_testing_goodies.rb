require 'cmless'
require 'nokogiri'

module CmlessTestingGoodies


  # Provide a module method for mixing this module into a class.
  # def self.add_to(klass)
  #   klass.send(:include, self)
  # end

  # Accessor to the namespaced location for all the testing goodies methods.
  attr_reader :__test

  def initialize(file_path)
    # Creates a namespaced location for all of the actual testing goodies.
    # This way it is hopefully unobtrusive
    @__test = CmlessTestingGoodiesClass.new(file_path)
    super
  end


  class CmlessTestingGoodiesClass

    attr_reader :ng

    def initialize(file_path)
      @ng = Nokogiri::HTML(Cmless::Markdowner.instance.render(File.read(file_path)))
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

    def hrefs
      @hrefs ||= ng.css('a').map { |link| link['href'] }
    end

    def mailtos
      @mailto ||= hrefs.grep(/^mailto\:/)
    end
  end
end