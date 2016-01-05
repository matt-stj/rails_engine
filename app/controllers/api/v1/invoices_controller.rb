class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    if params["status"]
      respond_with Invoice.find_by("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Invoice.find_by("#{params.first.first}": params.first.last)
    end
  end

  def find_all
    if params["status"]
      respond_with Invoice.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Invoice.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    offset = rand(Invoice.count)
    respond_with  Invoice.offset(offset).first
  end

end
