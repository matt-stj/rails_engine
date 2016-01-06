class Api::V1::Items::BestDaysController < ApplicationController
  respond_to :json

  def show
    item = Item.find_by(id: params[:item_id])
  end

end
