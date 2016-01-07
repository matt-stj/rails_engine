require 'test_helper'

class Api::V1::Invoices::MerchantsControllerTest < ActionController::TestCase
  test "#show returns the merchant for a given invoice" do
    merchant = Merchant.create!(name: "Turing")

    invoice = Invoice.create( customer_id: 2,
                 merchant_id: merchant.id,
                 status: "shipped"
           )


    get :show, :format => :json, invoice_id: invoice.id

    assert_response :success
    assert_equal "Turing", json_response['name']
  end
end
