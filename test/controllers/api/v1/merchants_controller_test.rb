require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  attr_reader :merchant

  def setup
    @merchant = Merchant.create(name: "Turing")

    3.times do |i|
      Merchant.create(name: "Turing#{i}")
    end
  end

  test "should get merchants index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "Turing2", json_response.first['name']
   assert_equal 4, json_response.count
   assert json_response.first['name']
  end

  test "should get merchants show page" do   get :show,  :format => :json, id: merchant.id

   assert_response :success

   assert_equal "Turing", json_response["name"]
  end

  test "should get single record from find:id" do    get :find,  :format => :json, id: merchant.id

    assert_response :success
    assert_equal "Turing", json_response["name"]
   end

   test "should get single record (case insensitive) from find:name" do
     get :find,  :format => :json, name: "TURING"

     assert_response :success

     assert_equal "Turing", json_response["name"]
    end

    test "#find_all should get all records that match the query" do
      created_second_record = Merchant.create(name: "TURING")

      get :find_all,  :format => :json, name: "Turing"

      assert_response :success

      assert_equal 2, json_response.count
      assert_equal "Turing", json_response.last["name"]
      assert_equal "TURING", json_response.first["name"]
     end

   test "#find_all on an :id should only return one record" do
     get :find_all,  :format => :json, id: Merchant.last.id

     assert_response :success

     assert_equal 1, json_response.count
    end

    test "can return a random record" do
      get :random,  :format => :json

      assert_response :success
     end

end
