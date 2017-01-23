require 'rails_helper'

describe PaymentMailer, type: :mailer do

  before(:each) do
    PaymentMailer.successful_transaction('jason_corum@wgbh.org').deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'should be sent to specified email address' do
    expect(ActionMailer::Base.deliveries.first.to.first).to eq('jason_corum@wgbh.org')
  end

  it 'should be sent from specified email address' do
    expect(ActionMailer::Base.deliveries.first.from.first).to eq('stock_sales@wgbh.org')
  end

  it 'should be sent with specified subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq('Thank You For your Purchase')
  end
end
