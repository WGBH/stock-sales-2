require 'rails_helper'

describe StocksalesMailer, type: :mailer do

  describe '#successful_transaction' do
    before(:each) do
      params = {"email"=>"test@test.com", "amount"=>"50", "description"=>"Tall Ships Footage", "action"=>"create", "controller"=>"payments"}
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
      params = {"email"=>"test@test.com", "amount"=>"50", "description"=>"Tall Ships Footage", "action"=>"create", "controller"=>"payments"}
      StocksalesMailer.suspect_transaction(params).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    # NEED TO CHANGE PRIOR TO LAUNCH
    it 'should be sent to specified email address' do
      expect(ActionMailer::Base.deliveries.first.to.first).to eq('jason_corum@wgbh.org')
    end

    it 'should be sent from specified email address' do
      expect(ActionMailer::Base.deliveries.first.from.first).to eq('stock_sales@wgbh.org')
    end

    it 'should be sent with specified subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Suspect Transaction')
    end
  end


end
