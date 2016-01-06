require 'test_helper'

class Api::V1::Items::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index returns all invoice items for a given item" do
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    3.times do |i|
      item.invoice_items.create( item_id: 2 + i,
                   invoice_id: 4 + i,
                   quantity: 1 + i,
                   unit_price: 3 + i
             )
      end

    get :index, :format => :json, item_id: item.id
    assert_response :success
    assert_equal item.invoice_items.count, json_response.count
  end
end
