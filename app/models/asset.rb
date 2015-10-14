class Asset
  def initialize(hash)
    @hash = hash
  end
  
  def to_json
    JSON.pretty_generate(@hash)
  end
  
  def to_solr
    {
      'id' => id,
      'json' => to_json,
      'text' => @hash.values
    }
  end
  
  # Obviously, we could pull directly from JSON, but this gives us
  # the ability to clean up the data at render time w/o reingesting,
  # which has been useful on AAPB. It also makes explicit which
  # fields are in use, unlike an OpenStruct.
  
  def artesia_id
    @artesia_id ||= @hash["artesia_id"]
  end
  def aspect_ratio
    @aspect_ratio ||= @hash["aspect_ratio"]
  end
  def barcode
    @barcode ||= @hash["barcode"]
  end
  def category
    @category ||= @hash["category"]
  end
  def ci_id
    @ci_id ||= @hash["ci_id"]
  end
  def clip_description
    @clip_description ||= @hash["clip_description"]
  end
  def clip_keywords
    @clip_keywords ||= @hash["clip_keywords"]
  end
  def clip_title
    @clip_title ||= @hash["clip_title"]
  end
  def codec
    @codec ||= @hash["codec"]
  end
  def digital_wrapper
    @digital_wrapper ||= @hash["digital_wrapper"]
  end
  def dimensions
    @dimensions ||= @hash["dimensions"]
  end
  def drive_name
    @drive_name ||= @hash["drive_name"]
  end
  def episode_number
    @episode_number ||= @hash["episode_number"]
  end
  def event_date
    @event_date ||= @hash["event_date"]
  end
  def event_location
    @event_location ||= @hash["event_location"]
  end
  def file_name
    @file_name ||= @hash["file_name"]
  end
  def folder_name
    @folder_name ||= @hash["folder_name"]
  end
  def format
    @format ||= @hash["format"]
  end
  def frames_per_second
    @frames_per_second ||= @hash["frames_per_second"]
  end
  def id
    @id ||= @hash["id"]
  end
  def length
    @length ||= @hash["length"]
  end
  def origin
    @origin ||= @hash["origin"]
  end
  def program
    @program ||= @hash["program"]
  end
  def series
    @series ||= @hash["series"]
  end
  def tape_number
    @tape_number ||= @hash["tape_number"]
  end
  def thumb_src
    @thumb_src ||= @hash["thumb_src"]
  end
  def time_in
    @time_in ||= @hash["time_in"]
  end
  def type
    @type ||= @hash["type"]
  end
  
  def video_small_src
    # TODO
    'https://s3.amazonaws.com/wgbhstocksales.org/content/Sales_homepage_reel_10072015_1200Kbps_480p.mp4'
  end
  def video_large_src
    # TODO
    'https://s3.amazonaws.com/wgbhstocksales.org/content/Sales_homepage_reel_10072015_1200Kbps_480p.mp4'
  end
  def watermarked_src
    @watermarked_src = "https://s3.amazonaws.com/wgbhstocksales.org/content/watermarked_clips/#{id}.mov"
  end
  
end
