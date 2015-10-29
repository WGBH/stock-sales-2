class SonyCiCache

  DEFAULT_EXPIRATION = 12.hours

  attr_reader :ci_id

  def initialize(ci_id)
    @ci_id = ci_id
  end

  def sony_ci_admin
    @sony_ci_admin ||= SonyCiAdmin.new(credentials_path: Rails.root + 'config/ci.yml')
  end

  def key_for(property)
    # naming convention for cache keys
    "sony_ci/#{ci_id}/#{property}"
  end

  def fetch(property, opts={}, &block)
    if block_given?
      Rails.cache.fetch(key_for(property), opts, &block)
    else
      Rails.cache.fetch(key_for(property), opts)
    end
  end

  def proxy_src(opts={})
    opts = {expires_in: DEFAULT_EXPIRATION}.merge(opts)
    fetch(:proxy_src, opts) do
      multi_details = sony_ci_admin.multi_details([ci_id], ['proxies'])
      all_proxies = multi_details['items'].first['proxies']
      all_proxies.select {|proxy| proxy['type'] == 'video-3g'}.first['location']
    end
  end
end