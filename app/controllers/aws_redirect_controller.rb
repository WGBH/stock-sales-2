require 'aws-sdk'

class AwsRedirectController < ApplicationController  
  ENV['AWS_REGION'] = 'us-east-1'
  SIGNER = Aws::S3::Presigner.new()
  # TODO: Should be able to set region in constructor, but didn't work for me.
  # .new(region: 'us-east-1')
  
  def extra_params
    {}
  end
  
  def show
    params = {
      bucket: 'wgbhstocksales.org', 
      key: "content/watermarked_clips/#{params[:id]}.mov"
    }.merge(extra_params)
    redirect_to SIGNER.presigned_url(:get_object, params)
  end
end