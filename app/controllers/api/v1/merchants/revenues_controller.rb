class Api::V1::Merchants::RevenuesController < ApplicationController
  respond_to :json

  def show
    merchant = Merchant.find_by(id: params[:merchant_id])
    #where status = success
    totals = merchant.invoice_items.map do |invoice_item|
      invoice_total_price = invoice_item.quantity * invoice_item.item.unit_price.to_f
    end.inject(0, :+)
    respond_with totals.round(2)
  end

successful_transactions =  Merchant.first.transactions.where(result: "success")
sum_of_unit_prices_on_invoice = successful_transactions.first.invoice.invoice_items.sum(:unit_price).to_f

end
