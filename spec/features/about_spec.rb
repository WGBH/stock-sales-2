require 'rails_helper'

describe About do

  About.each do |about|

    describe about.title do

      it 'works' do
        visit '/about/' + about.path
        expect(page.status_code).to eq(200)
      end

    end
  end
end