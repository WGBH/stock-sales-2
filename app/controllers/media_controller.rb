class MediaController < ApplicationController  
  include Blacklight::Catalog
  
  def show
    @response, @document = fetch(params['id'])
    redirect_to SonyCiCache.new(@document.ci_id).proxy_src
  end
end