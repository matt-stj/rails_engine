require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "should get merchants index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Invoice.create( customer_id: 2,
                merchant_id: 4,
                status: "shipped"
          )

   get :index,  :format => :json
   assert_response :success

   assert_equal 2, JSON.parse(response.body).first['customer_id']
   assert_equal "shipped", JSON.parse(response.body).first['status']
   assert_equal 4, JSON.parse(response.body).first['merchant_id']
  end
end
