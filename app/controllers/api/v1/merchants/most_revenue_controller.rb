class Api::V1::Merchants::MostRevenueController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.most_revenue(params[:quantity])
  end

end
