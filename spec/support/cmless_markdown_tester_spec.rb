require 'support/cmless_markdown_tester'

describe CmlessMarkdownTester do
  
  subject { described_class.new('./spec/fixtures/example_markdown.md') }

  describe 'broken_urls' do
    it 'returns a list of failed links' do
      expect(subject.broken_urls).to eq [ "http://invalid.example.org",
                                          "/invalid" ]
    end
  end

end