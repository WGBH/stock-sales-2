class DownloadsController < AwsRedirectController
  def extra_params
    clean_id = params[:id].gsub(/\W/,'') # DO NOT trust user input!
    {response_content_disposition: "attachment; filename=#{clean_id}.mov"}
  end
end