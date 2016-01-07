require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  attr_reader :customer

  def setup
    5.times do |i|
      Customer.create!(first_name: "Matt#{i}", last_name: "Smith#{i}")
      i +=1
    end

    @customer = Customer.create(first_name: "Matt", last_name: "Smith")

  end

  test "should get customers index" do
  get :index,  :format => :json

   assert_response :success
   assert_equal Customer.count, json_response.count
 end

 test "should get customers show page" do
    get :show,  :format => :json, id: customer.id

    assert_response :success
    assert_equal "Matt", json_response['first_name']
    assert_equal "Smith", json_response['last_name']
  end

  test "should get single record from find:id" do
     get :find,  :format => :json, id: customer.id

     assert_response :success
     assert_equal "Matt", json_response['first_name']
     assert_equal "Smith", json_response['last_name']
   end

   test "should get single record from find:first_name " do
      get :find,  :format => :json, first_name: "Matt"

      assert_response :success
      assert_equal "Matt", json_response['first_name']
      assert_equal "Smith", json_response['last_name']
    end

    test "should get single record (case-insensitive) from find:first_name " do
       get :find,  :format => :json, first_name: "MATT"

       assert_response :success

       assert_equal "Matt", json_response['first_name']
       assert_equal "Smith", json_response['last_name']
     end

    test "should get single record (case-insensitive) from find:last_name " do

       get :find,  :format => :json, last_name: "sMiTh"

       assert_response :success
       assert_equal "Matt", json_response['first_name']
       assert_equal "Smith", json_response['last_name']
     end

     test "#find_all should all records (case-insensitive) for query:name" do
       create_second_smith_record =
                                  Customer.create!( first_name: "Mike",
                                                    last_name: "Smith"
                                                  )
        get :find_all,  :format => :json, last_name: "sMiTh"

        assert_response :success
        assert_equal 2, json_response.count
        assert_equal "Smith", json_response.first['last_name']
        assert_equal "Smith", json_response.last['last_name']
      end

      test "#random should return a random customer" do
         get :random,  :format => :json

         assert_response :success
         assert json_response['first_name']
         assert json_response['last_name']
       end

end
