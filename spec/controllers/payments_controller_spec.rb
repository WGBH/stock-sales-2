require 'rails_helper'
require 'pry'

describe PaymentsController do
  describe 'POST index' do
    it 'sends an email to address in params' do
      expect { post :create, email: 'jason_corum@wgbh.org' }
      .to change { ActionMailer::Base.deliveries.count }.by(1)    end
  end
end
