require 'rails_helper'

describe PaymentsJs do

  let(:payment_attrs) {
    { amount: "50.00",
      order_number: "1234",
      email: "jason_corum@wgbh.org",
      address: '5 Fake Street',
      city: 'Boston',
      state: 'MA',
      zip: '12345',
      name: 'Jason Corum',
      description: 'Tall Ships Footage',
      wgbh_phone: '555-555-5555'
    }
  }

  let(:payment_js) { PaymentsJs.new(payment_attrs) }

  let(:result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2GHFem1b0\",\"message\":\"APPROVED 449449\",\"code\":\"449449\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"message\":\"Success\",\"data\":\"39e5de751ca9461783f1f524a42cea41\"},\"orderNumber\":\"1a2b\",\"transactionId\":\"ZWQ5OTkyNGRmNDUwZjc1MjFlYTIwYTY5ZmRiZTNiYTI\",\"timestamp\":\"2017-02-16T15:39:47.4645871-05:00\"},\"Hash\":\"vJIm2kflV6aL4cDVpSPZIGJ5gto35Nn0VjR78HImPrG5PXt8SbXkCnrxyPfQNkCXgj2guFbBZ lFdSfgbXaktQ==\"}"
  }

  let(:bad_result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2GHFem1b0\",\"message\":\"APPROVED 449449\",\"code\":\"449449\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"message\":\"Success\",\"data\":\"39e5de751ca9461783f1f524a42cea41\"},\"orderNumber\":\"1a2b\",\"transactionId\":\"ZWQ5OTkyNGRmNDUwZjc1MjFlYTIwYTY5ZmRiZTNiYTI\",\"timestamp\":\"2017-02-16T15:39:47.4645871-05:00\"},\"Hash\":\"vJIm2kflV6aL4cDVpSPZIGJ5gto35Nn0VjR78HImPrG5PXt8SbXkCnrxyPfQNkCXgj2guFbBZ lFdSfgbXaktQ==BAD==\"}"
  }

  describe "Payment attributes" do
    it "successfully populate on initialization" do
      payment = payment_js
      payment_js_attrs = {
        amount: payment.amount,
        order_number: payment.order_number,
        email: payment.email,
        address: payment.address,
        city: payment.city,
        state: payment.state,
        zip: payment.zip,
        name: payment.name,
        description: payment.description,
        wgbh_phone: payment.wgbh_phone
      }

      expect(payment_js_attrs).to eq(payment_attrs)
    end
  end

  describe '.check_result?' do
    it 'returns true if Hash is valid' do
      expect(PaymentsJs.check_result?(result)).to eq(true)
    end

    it 'return false if Hash is invalid' do
      expect(PaymentsJs.check_result?(bad_result)).to eq(false)
    end
  end
end
