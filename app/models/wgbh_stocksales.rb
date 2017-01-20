class WgbhStocksales

  smtp_creds = YAML.load_file(Rails.root + 'config/amazon_smtp.yml')
  SMTP_USER = smtp_creds['smtp_username']
  SMTP_PASSWORD = smtp_creds['smtp_password']

  PHONE     = '(617) 300-3939'
  EMAIL     = 'stock_sales@wgbh.org'
  FAQ_URL   = 'http://wgbhstocksales.com/about/faq'
  RATES_URL = 'http://wgbhstocksales.com/about/rates'

end
