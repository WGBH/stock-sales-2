require 'rails_helper'

describe PaymentsController do
  let(:result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==\"}"
  }

  let(:bad_result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==BAD==\"}"
  }

  let(:good_post) {
    post :create,
    email: 'test@test.org',
    amount: '50.00',
    description: 'Tall Ships Footage',
    order_number: '1234',
    wgbh_email: 'test@wgbh.org',
    wgbh_phone: '(555) 555-5555',
    result: result
  }

  let(:bad_post) {
    post :create,
    email: 'test@test.org',
    amount: '50.00',
    description: 'Tall Ships Footage',
    order_number: '1234',
    wgbh_email: 'test@wgbh.org',
    wgbh_phone: '(555) 555-5555',
    result: bad_result
  }

  let(:good_subject) { 'Thank You For your Purchase' }

  let(:bad_subject) { 'Suspect Transaction' }

  describe 'POST index' do

    before(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'sends success email if result hash is good' do
      expect{ good_post }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.first.subject).to eq(good_subject)
    end

    it 'sends suspect transaction email if result hash is bad' do
      expect{ bad_post }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.first.subject).to eq(bad_subject)
    end
  end
end
