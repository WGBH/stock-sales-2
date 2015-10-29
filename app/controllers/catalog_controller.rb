class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 20 
    }
  end
  
  def index
    super
    Rails.cache.read_multi(@document_list.map(&:ci_id)).tap do |ci_ids_to_proxy_urls|
      @ids_to_cached_proxy = Hash[
        @document_list.map do |document|
          [document.id, ci_ids_to_proxy_urls[[document.ci_id]]]
        end
      ]
    end
  end

end 
