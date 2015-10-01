require_relative '../../scripts/lib/fm_xml_converter'

describe FmXmlConverter do

  it 'converts record' do
    xml = File.read('spec/fixtures/fm-export-record.xml')
    json = FmXmlConverter.instance.convert_record(xml)
    json_expected = File.read('spec/fixtures/fm-export-record.expected.json')
    expect(json).to eq(json_expected)
  end
  
end
