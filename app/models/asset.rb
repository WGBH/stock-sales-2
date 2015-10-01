class Asset
  def initialize(json)
    @json = JSON.parse(json)
  end
  
  # Obviously, we could pull directly from JSON, but this gives us
  # the ability to clean up the data at render time w/o reingesting,
  # which has been useful on AAPB.
  def artesia_id
    @artesia_id ||= @json["artesia_id"]
  end
  def aspect_ratio
    @aspect_ratio ||= @json["aspect_ratio"]
  end
  def barcode
    @barcode ||= @json["barcode"]
  end
  def category
    @category ||= @json["category"]
  end
  def ci_id
    @ci_id ||= @json["ci_id"]
  end
  def clip_description
    @clip_description ||= @json["clip_description"]
  end
  def clip_keywords
    @clip_keywords ||= @json["clip_keywords"]
  end
  def clip_title
    @clip_title ||= @json["clip_title"]
  end
  def codec
    @codec ||= @json["codec"]
  end
  def digital_wrapper
    @digital_wrapper ||= @json["digital_wrapper"]
  end
  def dimensions
    @dimensions ||= @json["dimensions"]
  end
  def drive_name
    @drive_name ||= @json["drive_name"]
  end
  def episode_number
    @episode_number ||= @json["episode_number"]
  end
  def event_date
    @event_date ||= @json["event_date"]
  end
  def event_location
    @event_location ||= @json["event_location"]
  end
  def file_name
    @file_name ||= @json["file_name"]
  end
  def folder_name
    @folder_name ||= @json["folder_name"]
  end
  def format
    @format ||= @json["format"]
  end
  def frames_per_second
    @frames_per_second ||= @json["frames_per_second"]
  end
  def id
    @id ||= @json["id"]
  end
  def length
    @length ||= @json["length"]
  end
  def origin
    @origin ||= @json["origin"]
  end
  def program
    @program ||= @json["program"]
  end
  def series
    @series ||= @json["series"]
  end
  def tape_number
    @tape_number ||= @json["tape_number"]
  end
  def time_in
    @time_in ||= @json["time_in"]
  end
  def type
    @type ||= @json["type"]
  end
  
end
