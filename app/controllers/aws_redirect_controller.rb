require 'aws-sdk'

class AwsRedirectController < ApplicationController  
  ENV['AWS_REGION'] = 'us-east-1'
  SIGNER = Aws::S3::Presigner.new()
  # TODO: Should be able to set region in constructor, but didn't work for me.
  # .new(region: 'us-east-1')
  
  def show
    redirect_to SIGNER.presigned_url(:get_object, s3_params)
  end

  def s3_params
    {
      bucket: 'wgbhstocksales.org', 
      key: "content/watermarked_clips/#{params[:id]}.mov"
    }
  end
end
