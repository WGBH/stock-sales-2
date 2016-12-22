class PaymentsController < ApplicationController

  def index
    @billing_details =  { :name     => params[:name],
                          :amount   => params[:amount],
                          :address  => params[:address],
                          :city     => params[:city],
                          :state    => params[:state],
                          :postal   => params[:postal],
                          :order    => params[:order]
                        }

    if @billing_details[:amount].present? && @billing_details[:order].present?
      @payment = PaymentsJs.new(  amount: @billing_details[:amount],
                                  request_id: @billing_details[:order] )
    end
  end

end
