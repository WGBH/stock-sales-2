class WarmCacheController < ApplicationController
  SOLR = RSolr.connect(url: 'http://localhost:8983/solr/') # TODO: should come from config.
  def index
    number = SOLR.get('select', params: {q:'id:*', rows:0})['response']['numFound']
    ci_ids = SOLR.get('select', params: {q:'id:*', rows:number})['response']['docs'].map do |doc|
      JSON.parse(doc['json'])['ci_id']
    end
    
    ci = SonyCiAdmin.new(credentials_path: 'config/ci.yml')
    while !ci_ids.empty?
      group = ci_ids.shift(500) # Max dictated by the Sony API
      details = ci.multi_details(group, ['proxies'])
      details['items'].each do |item|
        Rails.cache.write(
          item['id'], 
          item['proxies'].select{|proxy| proxy['type']=='video-sd'}.first['location']
        )
      end
    end
    
    render text: "Cache warmed for all #{number}."
  end
end
