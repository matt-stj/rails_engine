class Api::V1::Invoices::TransactionsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Invoice.find_by(id: params[:invoice_id]).transactions
  end

end
