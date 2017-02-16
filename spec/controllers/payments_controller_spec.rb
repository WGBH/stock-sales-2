require 'rails_helper'

describe PaymentsController do
  let(:result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2GHFem1b0\",\"message\":\"APPROVED 449449\",\"code\":\"449449\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"message\":\"Success\",\"data\":\"39e5de751ca9461783f1f524a42cea41\"},\"orderNumber\":\"1a2b\",\"transactionId\":\"ZWQ5OTkyNGRmNDUwZjc1MjFlYTIwYTY5ZmRiZTNiYTI\",\"timestamp\":\"2017-02-16T15:39:47.4645871-05:00\"},\"Hash\":\"vJIm2kflV6aL4cDVpSPZIGJ5gto35Nn0VjR78HImPrG5PXt8SbXkCnrxyPfQNkCXgj2guFbBZ lFdSfgbXaktQ==\"}"
  }

  let(:bad_result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2GHFem1b0\",\"message\":\"APPROVED 449449\",\"code\":\"449449\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"message\":\"Success\",\"data\":\"39e5de751ca9461783f1f524a42cea41\"},\"orderNumber\":\"1a2b\",\"transactionId\":\"ZWQ5OTkyNGRmNDUwZjc1MjFlYTIwYTY5ZmRiZTNiYTI\",\"timestamp\":\"2017-02-16T15:39:47.4645871-05:00\"},\"Hash\":\"vJIm2kflV6aL4cDVpSPZIGJ5gto35Nn0VjR78HImPrG5PXt8SbXkCnrxyPfQNkCXgj2guFbBZ lFdSfgbXaktQ==BAD==\"}"
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
