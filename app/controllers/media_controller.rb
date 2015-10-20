class MediaController < ApplicationController  
  include Blacklight::Catalog
  
  def show
    @response, @document = fetch(params['id'])
    ci_id = Asset.new(JSON.parse(@document.instance_variable_get('@_source')['json'])).ci_id
    # TODO: Move multi_details to SonyCiBasic?
    # TODO: ... or add a method just for this?
    ci = SonyCiAdmin.new(credentials_path: Rails.root + 'config/ci.yml')
    # OAuth credentials expire: otherwise it would make sense to cache this instance.
    multi_details = ci.multi_details([ci_id], ['proxies'])
    all_proxies = multi_details['items'].first['proxies']
    proxy_url = all_proxies.select {|proxy| proxy['type'] == 'video-3g'}.first['location']
    redirect_to proxy_url
  end
end