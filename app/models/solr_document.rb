class SolrDocument 
  include Blacklight::Solr::Document

  attr_accessor :json

  def json
    @json ||= (JSON.parse(@_source[:json]) rescue {}).with_indifferent_access
  end

  def label_for(field)
    # Assume labels are the same as field names, sans underscores and
    # "clip_" prefix if it has one.
    field.to_s.gsub('_',' ').gsub(/clip /i, '')
  end

  def value_of(field)
    @_source[field] || json[field]
  end

  def labels_and_values(*fields)
    fields.map{ |field| {label: label_for(field), value: value_of(field)} }.select{ |pair| !pair[:value].nil? && !pair[:value].empty? }
  end
end
