class Api::V1::TransactionsController < ApplicationController
  respond_to :json

    def index
      respond_with Transaction.all
    end

    def show
      respond_with Merchant.find_by(id: params[:id])
    end

end
