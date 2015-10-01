require 'rails_helper'

describe About do

  About.each do |about|

    describe "visiting page \"#{about.title}\"" do

      it 'returns HTTP 200' do
        visit '/about/' + about.path
        expect(page.status_code).to eq(200)
      end

    end
  end
end