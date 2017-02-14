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
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==\"}"
  }

  let(:bad_result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==BAD==\"}"
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

  describe "#get_salt" do
    it 'does not return nil after initialization' do
      expect(payment_js.salt).to_not eq(nil)
    end

    it 'persists' do
      payment = payment_js
      expect(payment.salt).to eq(payment.get_salt)
    end
  end

  describe '#get_auth_key' do
    it 'does not return nil after initialization' do
      expect(payment_js.get_auth_key).to_not eq(nil)
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
