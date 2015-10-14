class User
  def initialize(request)
    @referer = request.referer
  end

  def stock_sales_referer?
    [/^(.+\.)?wgbhstocksales\.org$/].any? do |allowed|
      URI.parse(@referer).host =~ allowed
    end
  end
end
