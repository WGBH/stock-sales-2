require_relative '../../scripts/lib/ingester'
require_relative '../../scripts/lib/converter'

describe Ingester do
  
  before(:all) do
    @solr = Solr.instance.connect
    @solr.delete_by_query('*:*')
    @solr.commit
    
    File.write(Converter::THUMB_SRC_CACHE_PATH, '{"ci-98786543210": "http://example.com/fake-thumb"}')
  end
  
  it 'ingests assets' do
    expect_to_find('*', 0)
    Ingester.instance.ingest('spec/fixtures/fm-export-results.xml')
    expect_to_find('nova', 1)
  end
  
  def expect_to_find(search, n)
    response = @solr.get('select', params: {q: 'text:' + search})
    expect(response['response']['numFound']).to eq(n)
  end
  
end
