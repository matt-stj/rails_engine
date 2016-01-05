class Api::V1::CustomersController < ApplicationController
  respond_to :json

    def index
      respond_with Customer.all
    end

    def show
      respond_with Customer.find_by(id: params[:id])
    end

  def find
    if params["first_name"] || params["last_name"]
      respond_with Customer.find_by("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Customer.find_by("#{params.first.first}": params.first.last)
    end
  end

  def find_all
    if params["first_name"] || params["last_name"]
      respond_with Customer.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Customer.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    offset = rand(Customer.count)
    respond_with  Customer.offset(offset).first
  end

end
