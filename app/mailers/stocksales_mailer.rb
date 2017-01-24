class StocksalesMailer < ActionMailer::Base

  smtp_creds = YAML.load_file(Rails.root + 'config/amazon_smtp.yml')
  SMTP_USER = smtp_creds['smtp_username']
  SMTP_PASSWORD = smtp_creds['smtp_password']

  # NEED TO CHANGE PRIOR TO LAUNCH
  default from: "jason_corum@wgbh.org" # WgbhStocksales::EMAIL

  def successful_transaction(params)
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']

    mail(to: @email, subject: 'Thank You For your Purchase')
  end
end
