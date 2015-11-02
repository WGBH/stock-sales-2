require_relative '../../scripts/lib/converter'

describe Converter do
  
  it 'converts results' do
    xml = File.read('spec/fixtures/fm-export-results.xml')
    converted = Converter.new(xml, 'spec/fixtures/stock-sales-cache.json').first
    expected = SolrDocument.new({json: File.read('spec/fixtures/fm-export-record.expected.json')})
    expect(converted.labels_and_values).to eq(expected.labels_and_values)
  end
  
end
