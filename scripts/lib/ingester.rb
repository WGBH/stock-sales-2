require 'rsolr'
require 'date' # NameError deep in Solrizer without this.
require 'singleton'
require 'logger'
require_relative 'converter'
require_relative '../../lib/solr'
require_relative 'global_ingest_log'

class Ingester
  include Singleton

  def initialize
    @solr = Solr.instance.connect
  end

  def ingest(filename, cache_path = nil)
    if cache_path
      Converter.new(File.read(filename), cache_path)
    else
      Converter.new(File.read(filename))
    end.each do |solr_record|
      begin
        @solr.add(solr_record.to_solr)
        $LOG.info("Added #{solr_record.id}")
      rescue => e
        $LOG.error("Error on #{solr_record.id}: #{e}\n#{e.backtrace.join("\n")}")
      end
    end
    @solr.commit
    $LOG.info("Commit")
  end

end

if __FILE__ == $PROGRAM_NAME
  ARGV.each do |filename|
    Ingester.instance.ingest(filename)
  end
end
