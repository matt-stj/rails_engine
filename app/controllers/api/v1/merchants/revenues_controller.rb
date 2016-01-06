class Api::V1::Merchants::RevenuesController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.find_by(id: params[:merchant_id]).revenue
  end

end
