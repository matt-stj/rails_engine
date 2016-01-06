require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "should get invoice items index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   InvoiceItem.create( item_id: 2,
                invoice_id: 4,
                quantity: 1,
                unit_price: 3
          )

   get :index,  :format => :json
   assert_response :success

   assert_equal 2, json_response.first['item_id']
   assert_equal 4, json_response.first['invoice_id']
   assert_equal 1, json_response.first['quantity']
   assert_equal "3.0", json_response.first['unit_price']
  end

  test "should get show page for invoice items" do
    invoice_item = InvoiceItem.create( item_id: 2,
    invoice_id: 4,
    quantity: 1,
    unit_price: 3
    )

   get :show,  :format => :json, id: invoice_item.id
   assert_response :success

   assert_equal 2, json_response['item_id']
   assert_equal 4, json_response['invoice_id']
   assert_equal 1, json_response['quantity']
   assert_equal "3.0", json_response['unit_price']
  end

  test "should get individual invoice item with find" do
    invoice_item = InvoiceItem.create( item_id: 2,
    invoice_id: 4,
    quantity: 1,
    unit_price: 3
    )

   get :show,  :format => :json, id: invoice_item.id
   assert_response :success

   assert_equal 2, json_response['item_id']
   assert_equal 4, json_response['invoice_id']
  end
end
