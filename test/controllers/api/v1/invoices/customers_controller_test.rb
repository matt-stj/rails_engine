require 'test_helper'

class Api::V1::Invoices::CustomersControllerTest < ActionController::TestCase
  test "#show returns the customer for a given invoice" do

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )

    get :show, :format => :json, invoice_id: invoice.id

    assert_response :success
  end
end
