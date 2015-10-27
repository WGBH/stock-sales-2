require 'rails_helper'

describe "Validating collections:" do

  Collection.each do |collection|

    describe "Validating data for \"#{collection.title}\":" do

      it 'has working page' do
        visit '/collections/' + collection.path
        expect(page.status_code).to eq(200)
      end
      
      describe 'thumb_src' do
        # To run :link_check tests, set ENV['RSPEC_CHECK_LINKS']=true when
        # running rspec.
        it 'is a valid image url', :link_check do
          expect(collection.thumb_src).to be_a_valid_image_url
        end
      end

    end
  end
end