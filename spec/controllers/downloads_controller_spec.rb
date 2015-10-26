require 'rails_helper'

describe DownloadsController do
  describe 'GET show' do
    it 'redirects to a presigned S3 url' do
      get :show, id: 'foo'
      expect(response.location).to match /^https\:\/\/s3\.amazonaws.com\/wgbhstocksales.org\/content\/watermarked_clips\/foo.mov/
    end
  end
end
