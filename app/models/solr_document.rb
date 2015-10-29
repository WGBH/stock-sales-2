class SolrDocument

  include Blacklight::Solr::Document

  attr_accessor :json

  def json
    @json ||= (JSON.parse(@_source[:json]) rescue {}).with_indifferent_access
  end

  def labels_and_values(*fields)
    fields.map{ |field| { label: SolrDocument.label_for(field), value: send(field) } }.select{ |pair| !pair[:value].nil? && !pair[:value].empty? }
  end

  def artesia_id
    json[:artesia_id]
  end
  def aspect_ratio
    json[:aspect_ratio]
  end
  def barcode
    json[:barcode]
  end
  def category
    json[:category]
  end
  def ci_id
    json[:ci_id]
  end
  def clip_description
    json[:clip_description]
  end
  def clip_keywords
    json[:clip_keywords]
  end
  def clip_title
    json[:clip_title]
  end
  def codec
    json[:codec]
  end
  def digital_wrapper
    json[:digital_wrapper]
  end
  def dimensions
    json[:dimensions]
  end
  def drive_name
    json[:drive_name]
  end
  def episode_number
    json[:episode_number]
  end
  def event_date
    json[:event_date]
  end
  def event_location
    json[:event_location]
  end
  def file_name
    json[:file_name]
  end
  def folder_name
    json[:folder_name]
  end
  def format
    json[:format]
  end
  def frames_per_second
    json[:frames_per_second]
  end
  def id
    json[:id]
  end
  def length
    json[:length]
  end
  def origin
    json[:origin]
  end
  def program
    json[:program]
  end
  def proxy_src
    sony_ci.proxy_src
  end
  def sony_ci
    @sony_ci ||= SonyCiCache.new(ci_id)
  end
  def series
    json[:series]
  end
  def tape_number
    json[:tape_number]
  end
  def thumb_src
    json[:thumb_src]
  end
  def time_in
    json[:time_in]
  end
  def type
    json[:type]
  end
  def watermarked_src
    "/downloads/#{id}"
  end

  # CLASS METHODS

  def self.label_for(field)
    # Assume labels are the same as field names, sans underscores and
    # "clip_" prefix if it has one.
    field.to_s.gsub('_',' ').gsub(/clip /i, '')
  end
end
