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

   assert_equal 2, JSON.parse(response.body).first['item_id']
   assert_equal 4, JSON.parse(response.body).first['invoice_id']
   assert_equal 1, JSON.parse(response.body).first['quantity']
   assert_equal 0.03, JSON.parse(response.body).first['unit_price']
  end

  test "should get show page for invoice items" do
    invoice_item = InvoiceItem.create( item_id: 2,
    invoice_id: 4,
    quantity: 1,
    unit_price: 3
    )

   get :show,  :format => :json, id: invoice_item.id
   assert_response :success

   assert_equal 2, JSON.parse(response.body)['item_id']
   assert_equal 4, JSON.parse(response.body)['invoice_id']
   assert_equal 1, JSON.parse(response.body)['quantity']
   assert_equal 0.03, JSON.parse(response.body)['unit_price']
  end
end
