class Api::V1::TransactionsController < ApplicationController
  respond_to :json

    def index
      respond_with Transaction.all
    end

    def show
      respond_with Transaction.find_by(id: params[:id])
    end

    def find
      if params['result']
        respond_with Transaction.find_by("#{params.first.first} ILIKE ?", params.first.last)
      else
        respond_with Transaction.find_by("#{params.first.first}": params.first.last)
      end
    end

    def find_all
      if params['result']
        respond_with Transaction.where("#{params.first.first} ILIKE ?", params.first.last)
      else
        respond_with Transaction.where("#{params.first.first}": params.first.last)
      end
    end

end
