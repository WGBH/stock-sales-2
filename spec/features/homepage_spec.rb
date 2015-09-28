require 'rails_helper'
#require_relative '../support/validation_helper'

describe 'Homepage' do

  let(:important_text) do
    [
      "Over 50 years of footage, educational media, and web content from WGBH Boston",
      "Find Extensive Content in the WGBH Collections"
    ]
  end

  it 'has all the important text' do
    visit '/'
    expect(page.status_code).to eq(200)
    # TODO: find a way to do case insensitive match
    important_text.each do |text|
      expect(page).to have_text(text)  
    end
  end
end
