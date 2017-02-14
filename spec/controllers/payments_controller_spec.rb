require 'rails_helper'
require 'pry'

describe PaymentsController do

  let(:result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==\"}"
  }

  let(:bad_result) {
    "{\"Response\":{\"status\":\"Approved\",\"reference\":\"D2EHFF88e0\",\"message\":\"APPROVED 519519                 \",\"code\":\"519519\",\"cvvResult\":\"P\",\"avsResult\":\" \",\"riskCode\":\"00\",\"networkId\":\"10\",\"isPurchaseCard\":false,\"vaultResponse\":{\"status\":1,\"data\":\"67567508f6d241709df068adc59e6b76\"},\"orderNumber\":\"1\",\"transactionId\":\"ZmJlYzNiZjMwYzM3ZGJlNDYxZTYwMGEyMjE3YTdiYzY\",\"timestamp\":\"2017-02-14T15:15:08.535454-05:00\"},\"Hash\":\"pM/ br7N 9xczU 2WkH7xVwTEYFzLR0ps AnuG2fl7zOFY0Eij5X6e0kCMFxmsed1/0SOcMAFkSLXLUAjaBvUA==BAD==\"}"
  }

  describe 'POST index' do
    it 'sends a success email to address in params if hash is ' do
      expect { post :create, email: 'jason_corum@wgbh.org', amount: "50.00", description: "Tall Ships Footage", order_number: '1234', result: result }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
