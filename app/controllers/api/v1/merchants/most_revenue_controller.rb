class Api::V1::Merchants::MostRevenueController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.first
  end

end
