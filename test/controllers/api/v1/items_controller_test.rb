require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "should get merchants index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Item.create( name: "I-pod",
                description: "A nice thing that plays your music.",
                unit_price: 10000,
                merchant_id: 4
          )

   get :index,  :format => :json
   assert_response :success

   assert_equal "I-pod", JSON.parse(response.body).first['name']
   assert_equal "A nice thing that plays your music.", JSON.parse(response.body).first['description']
   assert_equal 10000, JSON.parse(response.body).first['unit_price']
   assert_equal 4, JSON.parse(response.body).first['merchant_id']
 end
end
