require_relative '../../scripts/lib/fm_xml_converter'

describe FmXmlConverter do

  it 'converts record' do
    xml = File.read('spec/fixtures/fm-export-record.xml')
    json = FmXmlConverter.convert_record(xml)
    json_expected = File.read('spec/fixtures/fm-export-record.expected.json')
    expect(json).to eq(json_expected)
  end
  
  it 'converts results' do
    xml = File.read('spec/fixtures/fm-export-results.xml')
    array = FmXmlConverter.new(xml).map { |json| json }
    json_expected = File.read('spec/fixtures/fm-export-record.expected.json')
    expect(array.first).to eq(json_expected)
  end
  
end
