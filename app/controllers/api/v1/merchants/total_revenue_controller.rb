class Api::V1::Merchants::TotalRevenueController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.total_revenue_for_date(params[:date])
  end

end
