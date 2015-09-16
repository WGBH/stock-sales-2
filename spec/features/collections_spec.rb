require 'rails_helper'
require 'support/link_check_matchers'

describe "Validating collections:" do

  @all_collections = Collection.all

  @all_collections.each do |collection|

    describe "Validating data for \"#{collection.title}\":" do

      describe 'thumbnail_url' do

        it 'is not using the placeholder' do
          expect(collection.thumbnail_url).to_not eq Collection::PLACEHOLDER_THUMBNAIL
        end

        it 'is a valid image url', :check_links do
          expect(collection.thumbnail_url).to be_a_valid_image_url
        end

      end

    end
  end
end