require 'test_helper'

class Api::V1::Merchants::InvoicesControllerTest < ActionController::TestCase
  test "#index should show all invoices for a merchant" do
    merchant =  Merchant.create(name: "Turing1")

    get :index, :format => :json, merchant_id: merchant.id
    assert_response :success
  end
end
