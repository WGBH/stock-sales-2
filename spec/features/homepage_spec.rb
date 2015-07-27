require 'rails_helper'
#require_relative '../support/validation_helper'

describe 'Homepage' do
  it 'has expected content' do
    visit '/'

    expect(page.status_code).to eq(200)
    expect(page).to have_text('Explore WGBH Collections')
  end
end
