require 'test_helper'

class Api::V1::Merchants::ItemsControllerTest < ActionController::TestCase
  test "#index should show all items for a merchant" do
    merchant =  Merchant.create(name: "Turing1")
    item = merchant.items.create(name: "I-pod",
                   description: "A nice thing that plays your music.",
                   unit_price: 10000,
                   merchant_id: 4
             )
     item_2 = merchant.items.create(name: "I-pod",
                    description: "A nice thing that plays your music.",
                    unit_price: 10000,
                    merchant_id: 4
              )

    get :index, :format => :json, merchant_id: merchant.id
    assert_response :success
    assert_equal 2, json_response.count
  end
end
