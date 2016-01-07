require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  attr_reader :invoice_item

  def setup
    @invoice_item = InvoiceItem.create( item_id: 2,
      invoice_id: 4,
      quantity: 1,
      unit_price: 3
      )

      3.times do |i|
        InvoiceItem.create( item_id: 2+i,
          invoice_id: 4+i,
          quantity: 1+i,
          unit_price: 3+i
          )
        end
  end

  test "should get invoice items index" do
   get :index,  :format => :json

   assert_response :success
   assert_equal InvoiceItem.count, json_response.count

   assert_equal 2, json_response.last['item_id']
   assert_equal 4, json_response.last['invoice_id']
   assert_equal 1, json_response.last['quantity']
   assert_equal "3.0", json_response.last['unit_price']
  end

  test "should get show page for invoice items" do
   get :show,  :format => :json, id: invoice_item.id

   assert_response :success
   assert_equal 2, json_response['item_id']
   assert_equal 4, json_response['invoice_id']
   assert_equal 1, json_response['quantity']
   assert_equal "3.0", json_response['unit_price']
  end

  test "should get individual invoice item with find" do
   get :find,  :format => :json, id: invoice_item.id
   assert_response :success

   assert_equal 2, json_response['item_id']
   assert_equal 4, json_response['invoice_id']
  end

  test "#find_all should all records (case-insensitive) for query" do
     get :find_all,  :format => :json, invoice_id: "4"

     assert_response :success
     assert_equal 2, json_response.count
   end

   test "#random returns a random record" do
      get :random,  :format => :json, invoice_id: "4"

      assert_response :success
      assert json_response['item_id']
      assert json_response['invoice_id']
    end
end
