require 'test_helper'

class Api::V1::Items::MerchantsControllerTest < ActionController::TestCase
  test "#show returns the merchant for a given item" do
    item = Item.create!( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )
    merchant = Merchant.create!(id: 4, name: "Turing")

    get :show, :format => :json, item_id: item.id

    assert_response :success
    assert_equal item.merchant.name, json_response['name']
  end
end
