require 'test_helper'

class Api::V1::InvoiceItems::InvoicesControllerTest < ActionController::TestCase
  test "#show returns invoice for a given invoice_item" do

  invoice_item =  InvoiceItem.create( item_id: 2,
                 invoice_id: 4,
                 quantity: 1,
                 unit_price: 3
           )
  invoice = Invoice.create(id: 4, status: "test invoice")

    get :show, :format => :json, invoice_item_id: invoice_item.id

    assert_response :success
    assert_equal "test invoice", json_response['status']
  end
end
