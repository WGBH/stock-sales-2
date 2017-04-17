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

RSpec::Matchers.define :be_a_working_link do
  match do |check_link|
    begin
      # Accept all 2xx and 3xx as a good HTTP return status
      good_statuses = (200..399)

      binding.pry unless good_statuses.include?(Faraday.head(check_link).status)

      good_statuses.include? Faraday.head(check_link).status
    rescue
      raise "Failed when checking URL: \"#{check_link}\""
    end
  end
end