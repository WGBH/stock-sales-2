class WarmCacheController < ApplicationController
  SOLR = RSolr.connect(url: 'http://localhost:8983/solr/') # TODO: should come from config.
  def index
    number = SOLR.get('select', params: {q:'id:*', rows:0})['response']['numFound']
    SOLR.get('select', params: {q:'id:*', rows:number})['response']['docs'].map do |doc|
      ci_id = JSON.parse(doc['json'])['ci_id']
      SonyCiCache.new(ci_id).proxy_src(force: true)
    end
    
    render text: "Cache warmed for all #{number}."
  end
end
