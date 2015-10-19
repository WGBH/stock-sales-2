require 'aws-sdk'

class DownloadsController < ApplicationController  
  ENV['AWS_REGION'] = 'us-east-1'
  SIGNER = Aws::S3::Presigner.new()
  # TODO: Should be able to set region in constructor, but didn't work for me.
  # .new(region: 'us-east-1')
  
  def show
    filename = "#{params[:id]}.mov"
    url = SIGNER.presigned_url(:get_object, 
      bucket: 'wgbhstocksales.org', 
      key: "content/watermarked_clips/#{filename}",
      response_content_disposition: "attachment; filename=#{filename}"
    )
    redirect_to url
  end
end