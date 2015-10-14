require_relative '../../scripts/lib/converter'

describe Converter do
  
  it 'converts results' do
    xml = File.read('spec/fixtures/fm-export-results.xml')
    array = Converter.new(xml, 'spec/fixtures/stock-sales-cache.json').map { |asset| asset.to_json }
    json_expected = File.read('spec/fixtures/fm-export-record.expected.json')
    expect(array.first).to eq(json_expected)
  end
  
end
