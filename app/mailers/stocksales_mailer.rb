class StocksalesMailer < ActionMailer::Base

  default from: WgbhStocksales::EMAIL

  def successful_transaction(params)
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']
    @wgbh_phone   = params['wgbh_phone']
    @wgbh_email   = params['wgbh_email']

    mail(to: @email, subject: 'Thank You For your Purchase')
  end

  def suspect_transaction(params)
    @order_number = params['order_number']
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']
    @wgbh_email   = params['wgbh_email']
    @result       = params['result']

    mail(to: @wgbh_email, subject: 'Suspect Transaction')
  end
end
