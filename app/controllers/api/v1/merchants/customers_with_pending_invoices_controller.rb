class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  respond_to :json
  
  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).customers_with_pending_invoices
  end

end
