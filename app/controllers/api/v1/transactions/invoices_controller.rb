class Api::V1::Transactions::InvoicesController < ApplicationController
  respond_to :json

  def show
    respond_with Transaction.find_by(id: params[:transaction_id]).invoice
  end
end
