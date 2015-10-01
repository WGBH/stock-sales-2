require 'rsolr'
require 'date' # NameError deep in Solrizer without this.
require 'singleton'
require_relative 'converter'
require_relative '../../lib/solr'

class Ingester
  include Singleton

  def initialize
    @solr = Solr.instance.connect
  end

  def ingest(filename)
    Converter.new(File.read(filename)).each do |asset|
      @solr.add(asset.to_solr)
    end
    @solr.commit
  end

end
