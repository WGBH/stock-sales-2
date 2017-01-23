require 'rails_helper'
require 'yaml'

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
      description: 'Tall Ships Footage'
    }
  }

  let(:payment_js) { PaymentsJs.new(payment_attrs) }

  let(:expected_credentials) { YAML.load_file(Rails.root + 'config/payments_js.yml') }

  describe "Sage credentials" do
    it 'successfully load' do
      payment = payment_js
      payment_credentials = {
        'mid'           => payment.mid.to_i,
        'mkey'          => payment.mkey,
        'client_id'     => payment.client_id,
        'client_secret' => payment.client_secret
      }

      expect(payment_credentials).to eq(expected_credentials)
    end
  end

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
        description: payment.description
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
end
