require 'test_helper'

class Api::V1::Items::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index returns all invoice items for a given item" do
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    get :index, :format => :json, item_id: item.id
    assert_response :success
  end
end
