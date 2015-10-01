require_relative '../../scripts/lib/ingester'

describe Ingester do
  
  before(:all) do
    @solr = Solr.instance.connect
    @solr.delete_by_query('*:*')
    @solr.commit
  end
  
  it 'ingests assets' do
    expect_to_find(0)
    Ingester.instance.ingest('spec/fixtures/fm-export-results.xml')
    expect_to_find(1)
  end
  
  def expect_to_find(n)
    response = @solr.get('select', params: {q: '*:*'})
    expect(response['response']['numFound']).to eq(n)
  end
  
end
