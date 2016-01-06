require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "should get merchants index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Merchant.create(name: "Turing")

   get :index,  :format => :json
   assert_response :success

   assert_equal "Turing", json_response.first['name']
  end

  test "should get merchants show page" do
   merchant = Merchant.create(name: "Turing")
   get :show,  :format => :json, id: merchant.id

   assert_response :success

   assert_equal "Turing", json_response["name"]
  end

  test "should get single record from find:id" do
    merchant = Merchant.create(name: "Turing")
    get :find,  :format => :json, id: merchant.id

    assert_response :success
    assert_equal "Turing", json_response["name"]
   end

   test "should get single record (case insensitive) from find:name" do
     merchant = Merchant.create(name: "Turing")
     get :find,  :format => :json, name: "TURING"

     assert_response :success

     assert_equal "Turing", json_response["name"]
    end

    test "#find_all should get all records that match the query" do
      merchant = Merchant.create(name: "Turing")
      get :find,  :format => :json, name: "TURING"

      assert_response :success

      assert_equal "Turing", json_response["name"]
     end

    test "can return a random record" do
      Merchant.create(name: "Turing1")
      Merchant.create(name: "Turing2")
      Merchant.create(name: "Turing3")

      get :random,  :format => :json

      assert_response :success
     end

end
