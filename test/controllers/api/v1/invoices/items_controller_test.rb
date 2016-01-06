require 'test_helper'

class Api::V1::Invoices::ItemsControllerTest < ActionController::TestCase
  test "#index returns the items for a given invoice" do

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )

    get :index, :format => :json, invoice_id: invoice.id

    assert_response :success
  end
end
