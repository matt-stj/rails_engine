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

 test "should get customers show page" do
    customer = Customer.create(first_name: "Matt", last_name: "Smith")

    get :show,  :format => :json, id: customer.id

    assert_response :success
    assert_equal "Matt", JSON.parse(response.body)['first_name']
    assert_equal "Smith", JSON.parse(response.body)['last_name']
  end

  test "should get single record from find:id" do
     customer = Customer.create(first_name: "Matt", last_name: "Smith")

     get :find,  :format => :json, id: customer.id

     assert_response :success
     assert_equal "Matt", JSON.parse(response.body)['first_name']
     assert_equal "Smith", JSON.parse(response.body)['last_name']
   end

   test "should get single record from find:first_name " do
      customer = Customer.create(first_name: "Matt", last_name: "Smith")

      get :find,  :format => :json, first_name: "Matt"

      assert_response :success
      assert_equal "Matt", JSON.parse(response.body)['first_name']
      assert_equal "Smith", JSON.parse(response.body)['last_name']
    end

    test "should get single record (case-insensitive) from find:first_name " do
       customer = Customer.create(first_name: "Matt", last_name: "Smith")

       get :find,  :format => :json, first_name: "MATT"

       assert_response :success

       assert_equal "Matt", JSON.parse(response.body)['first_name']
       assert_equal "Smith", JSON.parse(response.body)['last_name']
     end

    test "should get single record (case-insensitive) from find:last_name " do
       customer = Customer.create(first_name: "Matt", last_name: "Smith")

       get :find,  :format => :json, last_name: "sMiTh"

       assert_response :success
       assert_equal "Matt", JSON.parse(response.body)['first_name']
       assert_equal "Smith", JSON.parse(response.body)['last_name']
     end
end
