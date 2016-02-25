class ThumbController < ApplicationController  
  include Blacklight::Catalog
  
  def show
    @response, @document = fetch(params['id'])
    redirect_to @document.thumb_src
  end
end