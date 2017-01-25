class StocksalesMailer < ActionMailer::Base

  # NEED TO CHANGE PRIOR TO LAUNCH
  default from: "jason_corum@wgbh.org" # WgbhStocksales::EMAIL

  def successful_transaction(params)
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']

    mail(to: @email, subject: 'Thank You For your Purchase')
  end
end
