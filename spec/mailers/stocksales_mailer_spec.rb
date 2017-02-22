require 'rails_helper'

describe StocksalesMailer, type: :mailer do

  let(:result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==\"}"
  }

  describe '#successful_transaction' do
    before(:each) do
      params = {
        "email"=>"test@test.com",
        "amount"=>"50",
        "description"=>"Tall Ships Footage",
        "wgbh_email" =>"test@wgbh.org",
        "wgbh_phone" => "(555) 555-5555",
        "result" => result,
        "action"=>"create",
        "controller"=>"payments"
      }
      StocksalesMailer.successful_transaction(params).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should be sent to specified email address' do
      expect(ActionMailer::Base.deliveries.first.to.first).to eq('test@test.com')
    end

    it 'should be sent from specified email address' do
      expect(ActionMailer::Base.deliveries.first.from.first).to eq('stock_sales@wgbh.org')
    end

    it 'should be sent with specified subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Thank You For your Purchase')
    end
  end

  describe '#suspect_transaction' do
    before(:each) do
      params = {
        "email"=>"test@test.com",
        "amount"=>"50",
        "description"=>"Tall Ships Footage",
        "wgbh_email" =>"test@wgbh.org",
        "wgbh_phone" => "(555) 555-5555",
        "action"=>"create",
        "result" => result,
        "controller"=>"payments"
      }
      StocksalesMailer.suspect_transaction(params).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should be sent to specified email address' do
      expect(ActionMailer::Base.deliveries.first.to.first).to eq('test@wgbh.org')
    end

    it 'should be sent from specified email address' do
      expect(ActionMailer::Base.deliveries.first.from.first).to eq('stock_sales@wgbh.org')
    end

    it 'should be sent with specified subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Suspect Transaction')
    end

    it 'should have the result hash in the body' do
      expect(ActionMailer::Base.deliveries.first.parts.first.body.raw_source).to include(result)
    end
  end


end
