class StocksalesMailer < ActionMailer::Base

  default from: WgbhStocksales::EMAIL

  def successful_transaction(params)
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']
    @wgbh_phone   = params['wgbh_phone']

    mail(to: @email, subject: 'Thank You For your Purchase')
  end

  def suspect_transaction(params)
    @order_number = params['order_number']
    @description  = params['description']
    @amount       = params['amount']
    @email        = params['email']

    # NEED TO CHANGE PRIOR TO LAUNCH
    mail(to: 'jason_corum@wgbh.org', subject: 'Suspect Transaction')
  end
end
