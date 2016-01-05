class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_by("#{params.first.first}": params.first.last)
  end

  def find_all
    respond_with InvoiceItem.where("#{params.first.first}": params.first.last)
  end

  def random
    offset = rand(InvoiceItem.count)
    respond_with  InvoiceItem.offset(offset).first
  end
end
