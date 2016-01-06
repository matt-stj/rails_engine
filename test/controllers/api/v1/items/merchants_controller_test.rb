require 'test_helper'

class Api::V1::Items::MerchantsControllerTest < ActionController::TestCase
  test "#show returns the merchant for a given item" do
    skip
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    get :index, :format => :json, item_id: item.id
    assert_response :success
  end
end
