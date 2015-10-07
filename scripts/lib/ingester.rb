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

  def ingest(filename, cache_path = nil)
    errors = []
    if cache_path
      Converter.new(File.read(filename), cache_path)
    else
      Converter.new(File.read(filename))
    end.each do |asset|
      begin
        @solr.add(asset.to_solr)
        puts "Added #{asset.id}"
      rescue => e
        errors.push(asset.id)
        puts "Error on #{asset.id}: #{e}"
      end
    end
    @solr.commit
    puts "Commit"
    puts "#{errors.count} errors"
  end

end

if __FILE__ == $PROGRAM_NAME
  ARGV.each do |filename|
    Ingester.instance.ingest(filename)
  end
end
