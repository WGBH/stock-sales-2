class PaymentsController < ApplicationController

  def index
    return unless params[:amount].present? && params[:order].present? && params[:email].present?

    @payment = PaymentsJs.new(  amount: params[:amount],
                                order_number: params[:order],
                                request_type: 'payment',
                                name: params[:name],
                                address: params[:address],
                                city: params[:city],
                                state: params[:state],
                                zip: params[:zip],
                                email: params[:email],
                                environment: 'cert',
                                pre_auth: 'false' )
  end

  def create
    return unless params[:email].present?
    PaymentMailer.successful_transaction(params[:email])
    render :index
  end

end
