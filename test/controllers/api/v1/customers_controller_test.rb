require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  def setup
    5.times do |i|
      Customer.create!(first_name: "Matt#{i}", last_name: "Smith#{i}")
      i +=1
    end
  end

  test "should get customers index" do
  get :index,  :format => :json

   assert_response :success
   assert_equal "Matt4", json_response.first['first_name']
   assert_equal "Smith4", json_response.first['last_name']
 end

 test "should get customers show page" do
    customer = Customer.create(first_name: "Matt", last_name: "Smith")

    get :show,  :format => :json, id: customer.id

    assert_response :success
    assert_equal "Matt", json_response['first_name']
    assert_equal "Smith", json_response['last_name']
  end

  test "should get single record from find:id" do
     customer = Customer.create(first_name: "Matt", last_name: "Smith")

     get :find,  :format => :json, id: customer.id

     assert_response :success
     assert_equal "Matt", json_response['first_name']
     assert_equal "Smith", json_response['last_name']
   end

   test "should get single record from find:first_name " do
      customer = Customer.create(first_name: "Matt", last_name: "Smith")

      get :find,  :format => :json, first_name: "Matt"

      assert_response :success
      assert_equal "Matt", json_response['first_name']
      assert_equal "Smith", json_response['last_name']
    end

    test "should get single record (case-insensitive) from find:first_name " do
       customer = Customer.create(first_name: "Matt", last_name: "Smith")

       get :find,  :format => :json, first_name: "MATT"

       assert_response :success

       assert_equal "Matt", json_response['first_name']
       assert_equal "Smith", json_response['last_name']
     end

    test "should get single record (case-insensitive) from find:last_name " do
       customer = Customer.create(first_name: "Matt", last_name: "Smith")

       get :find,  :format => :json, last_name: "sMiTh"

       assert_response :success
       assert_equal "Matt", json_response['first_name']
       assert_equal "Smith", json_response['last_name']
     end
end
