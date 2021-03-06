require 'rspec/expectations'
require 'faraday'

RSpec::Matchers.define :be_a_valid_image_url do
  match do |check_link|
    begin
      Faraday.head(check_link).headers['content-type'] =~ /^image/
    rescue
      # Catch any odd Faraday errors and simply report a bad url.
      raise "Failed when checking URL: \"#{check_link}\""
    end
  end
end