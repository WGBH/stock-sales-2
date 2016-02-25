require 'rails_helper'

describe ThumbController do
  before(:all) do
    Ingester.instance.ingest('spec/fixtures/fm-export-results.xml', 'spec/fixtures/stock-sales-cache.json')
  end
  describe 'GET show' do
    it 'redirects to an S3 url' do
      get :show, id: 'GBH000123'
      expect(response.location).to eq 'https://d14nxlyhj878kl.cloudfront.net/cifiles/5cf8d001d37241a59d07d594010bdab9/thumbnail.jpg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiKjovL2QxNG54bHloajg3OGtsLmNsb3VkZnJvbnQubmV0L2NpZmlsZXMvNWNmOGQwMDFkMzcyNDFhNTlkMDdkNTk0MDEwYmRhYjkvdGh1bWJuYWlsLmpwZyIsIkNvbmRpdGlvbiI6eyJJcEFkZHJlc3MiOnsiQVdTOlNvdXJjZUlwIjoiMC4wLjAuMC8wIn0sIkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTA3OTE5MDE5fX19XX0_&Signature=XkDhbBUJIO1hW26uaHXkafHwgIF2ODlDjC-C2Fj2zBAaGA0393Wh4xOOfsbMaYZK~qislaoGqaWdC5GCziBDFSmR-9Z6XBzRfggl8GOj62vYATBdmBIKh-yC6Z82gmX718fJQ96ezKGLzVIZUVUGTvGRat6oE86~Stgboji7zP8_&Key-Pair-Id=APKAJNUSFH4IKQRZ44WA'
    end
  end
end
