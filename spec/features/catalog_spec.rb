require 'rails_helper'
#require_relative '../support/validation_helper'

describe 'Catalog' do

  it 'loads, at least' do
    visit '/catalog'
    expect(page.status_code).to eq(200)
  end
  
end
