class PaymentsController < ApplicationController

  def index
    return unless params[:amount].present? && params[:order].present?

    @payment = PaymentsJs.new(  amount: params[:amount],
                                order_number: params[:order],
                                request_type: 'payment',
                                name: params[:name],
                                address: params[:address],
                                city: params[:city],
                                state: params[:state],
                                zip: params[:zip],
                                environment: 'cert',
                                pre_auth: 'false' )
  end

end
