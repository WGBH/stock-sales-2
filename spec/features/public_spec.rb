require 'rails_helper'

describe '/public' do

  it 'serves the xsl expected by Filemaker' do
    visit '/fm_to_csv.xsl'
    expect(page.status_code).to eq(200)
  end

end