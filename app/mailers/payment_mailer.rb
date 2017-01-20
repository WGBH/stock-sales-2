class PaymentMailer < ActionMailer::Base

  # NEED TO CHANGE PRIOR TO LAUNCH
  default from: "jason_corum@wgbh.org"

  def successful_transaction(email)
    mail(to: email, subject: 'Thank You For your Purchase')
  end
end
