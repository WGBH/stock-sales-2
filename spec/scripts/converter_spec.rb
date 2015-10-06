require_relative '../../scripts/lib/converter'

describe Converter do
  
  before(:all) do
    @orig_cache = File.read(Converter::THUMB_SRC_CACHE_PATH) rescue nil
    File.write(Converter::THUMB_SRC_CACHE_PATH, '{"ci-98786543210": "http://example.com/fake-thumb"}')
  end
  
  after(:all) do
    File.write(Converter::THUMB_SRC_CACHE_PATH, @orig_cache) if @orig_cache
  end
  
  it 'converts results' do
    File.write(Converter::THUMB_SRC_CACHE_PATH, '{"ci-98786543210": "http://example.com/fake-thumb"}')
    
    xml = File.read('spec/fixtures/fm-export-results.xml')
    array = Converter.new(xml).map { |asset| asset.to_json }
    json_expected = File.read('spec/fixtures/fm-export-record.expected.json')
    expect(array.first).to eq(json_expected)
  end
  
end
