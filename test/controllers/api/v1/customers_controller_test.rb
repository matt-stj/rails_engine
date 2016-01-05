require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "should get customers index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Customer.create(first_name: "Matt", last_name: "Smith")

   get :index,  :format => :json
   assert_response :success

   assert_equal "Matt", JSON.parse(response.body).first['first_name']
   assert_equal "Smith", JSON.parse(response.body).first['last_name']
 end
end