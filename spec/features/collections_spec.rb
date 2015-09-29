require 'rails_helper'
require 'support/link_check_matchers'

describe "Validating collections:" do

  Collection.each do |collection|

    describe "Validating data for \"#{collection.title}\":" do

      it 'has working page' do
        visit '/collection/' + collection.path
        expect(page.status_code).to eq(200)
      end
      
      describe 'thumbnail_url' do
        # To run :check_links tests, set ENV['RSPEC_CHECK_LINKS']=true when
        # running rspec.
        it 'is a valid image url', :check_links do
          expect(collection.thumbnail_url).to be_a_valid_image_url
        end
      end

    end
  end
end