require 'rails_helper'
require 'support/cmless_markdown_tester'

describe 'Markdown for Cmless classes' do

  @cmless_classes = [About, Collection]

  # Get a list of all markdown files under each Cmless class's ROOT path.
  @files = @cmless_classes.map{ |klass| Dir["#{klass::ROOT}/**/*.md"] }.flatten


  @files.each do |path|

    # Use relative path for easier-to-read output from rspec.
    relative_path = path.gsub(/^#{File.expand_path('./')}/, '')

    context "at \"#{relative_path}\"" do

      let(:cmless_markdown_tester) { CmlessMarkdownTester.new(path) } 

      context "with URLs" do
        # Ignore relative and empty URLs.
        let(:ignore_these_urls) { [/^\//, /^$/] }
        let(:broken_external_urls) do
          cmless_markdown_tester.broken_urls.reject do |url|
            ignore_these_urls.any? { |ignore_this_url|  url =~ ignore_this_url }
          end
        end

        it "does not have any broken external urls" do
          expect(broken_external_urls).to eq []
        end
      end
    end
  end
end