class Api::V1::Merchants::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).invoices
  end

end
