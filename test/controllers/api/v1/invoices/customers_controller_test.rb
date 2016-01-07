require 'test_helper'

class Api::V1::Invoices::CustomersControllerTest < ActionController::TestCase
  test "#show returns the customer for a given invoice" do

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )
    customer = Customer.create(id: 2, first_name: "Customer")

    get :show, :format => :json, invoice_id: invoice.id

    assert_response :success
    assert_equal "Customer", json_response['first_name']
  end
end
