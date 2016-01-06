require 'test_helper'

class Api::V1::Invoices::MerchantsControllerTest < ActionController::TestCase
  test "#show returns the merchant for a given invoice" do

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )

    get :show, :format => :json, invoice_id: invoice.id

    assert_response :success
  end
end
