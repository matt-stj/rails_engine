class Api::V1::Items::MostItemRevenueController < ApplicationController
respond_to :json

   def index
     respond_with Item.most_revenue_items(params["quantity"])
   end

end
