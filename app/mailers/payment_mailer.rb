class PaymentMailer < ActionMailer::Base

  default from: "stock_sales@wgbh.org"

  def successful_transaction(email)
    mail(to: email, subject: 'Thank You For your Purchase')
  end
end
