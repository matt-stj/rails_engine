require 'test_helper'

class Api::V1::Merchants::InvoicesControllerTest < ActionController::TestCase
  test "#index should show all invoices for a merchant" do
    merchant =  Merchant.create(name: "Turing1")

    merchant.invoices.create(status: "shipped")
    merchant.invoices.create(status: "shipped")

    get :index, :format => :json, merchant_id: merchant.id
    assert_response :success
    assert_equal 2, json_response.count
  end
end
