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

  test "should get merchants show page" do
   merchant = Merchant.create(name: "Turing")
   get :show,  :format => :json, id: merchant.id

   assert_response :success

   assert_equal "Turing", JSON.parse(response.body)["name"]
  end
end
