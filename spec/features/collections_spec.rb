require 'rails_helper'
require 'support/link_check_matchers'

describe "Validating collections:" do

  @all_collections = Collection.all

  @all_collections.each do |collection|

    describe "Validating data for \"#{collection.title}\":" do

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