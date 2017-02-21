class PaymentsController < ApplicationController

  def index
    return unless
        params[:amount].present? &&
        params[:order].present? &&
        params[:email].present? &&
        params[:description].present?

    @payment = PaymentsJs.new(  amount: params[:amount],
                                order_number: params[:order],
                                name: params[:name],
                                address: params[:address],
                                city: params[:city],
                                state: params[:state],
                                zip: params[:zip],
                                email: params[:email],
                                description: params[:description],
                                wgbh_phone: params[:wgbh_phone],
                                wgbh_email: params[:wgbh_email] )
  end

  def create
    return unless
        params[:amount].present? &&
        params[:email].present? &&
        params[:order_number].present? &&
        params[:description].present? &&
        params[:result].present?

    if PaymentsJs.check_result?(params[:result])
        StocksalesMailer.successful_transaction(params).deliver
        render :nothing => true
    else
        StocksalesMailer.suspect_transaction(params).deliver
        render :nothing => true
    end
  end

end
