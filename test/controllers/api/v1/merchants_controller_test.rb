require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "should get merchants index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Merchant.create(name: "Turing")

   get :index,  :format => :json
   assert_response :success

   assert_equal "Turing", JSON.parse(response.body).first['name']
  end
end