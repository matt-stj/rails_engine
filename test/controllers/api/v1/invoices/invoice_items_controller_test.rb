require 'test_helper'

class Api::V1::Invoices::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index returns invoice_items for a given invoice" do

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )
    3.times do |i|
      invoice.invoice_items.create(quantity: i)
    end

    get :index, :format => :json, invoice_id: invoice.id

    assert_response :success
    assert_equal 3, json_response.count
  end
end
