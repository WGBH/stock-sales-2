class DownloadsController < AwsRedirectController  
  def extra_params
    {response_content_disposition: "attachment; filename=wgbh-stock-sales.mov"}
  end
end