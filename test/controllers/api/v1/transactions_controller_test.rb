require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "should get transactions index" do
   get :index,  :format => :json
   assert_response :success

   assert_equal "[]", response.body

   Transaction.create( invoice_id: 1,
                    credit_card_number: "1234567",
                    result: "success"
                  )

   get :index,  :format => :json

   assert_response :success
   assert_equal 1, JSON.parse(response.body).first['invoice_id']
   assert_equal "1234567", JSON.parse(response.body).first['credit_card_number']
   assert_equal "success", JSON.parse(response.body).first['result']
  end

  test "should get transactions show page" do
   transaction =  Transaction.create( invoice_id: 1,
                    credit_card_number: "1234567",
                    result: "success"
                  )

   get :show,  :format => :json, id: transaction.id

   assert_response :success
   assert_equal 1, JSON.parse(response.body)['invoice_id']
   assert_equal "1234567", JSON.parse(response.body)['credit_card_number']
   assert_equal "success", JSON.parse(response.body)['result']
  end

  test "should get single record for find:id" do
   transaction =  Transaction.create( invoice_id: 1,
                    credit_card_number: "1234567",
                    result: "success"
                  )

   get :find,  :format => :json, id: transaction.id

   assert_response :success
   assert_equal 1, JSON.parse(response.body)['invoice_id']
   assert_equal "1234567", JSON.parse(response.body)['credit_card_number']
   assert_equal "success", JSON.parse(response.body)['result']
  end

  test "should get single record for find:credit_card_number" do
   transaction =  Transaction.create( invoice_id: 1,
                    credit_card_number: "1234567",
                    result: "success"
                  )

   get :find,  :format => :json, credit_card_number: "1234567"

   assert_response :success
   assert_equal 1, JSON.parse(response.body)['invoice_id']
   assert_equal "1234567", JSON.parse(response.body)['credit_card_number']
   assert_equal "success", JSON.parse(response.body)['result']
  end

  test "should get single record (case-insensitive) for find:result" do
   transaction =  Transaction.create( invoice_id: 1,
                    credit_card_number: "1234567",
                    result: "success"
                  )

   get :find,  :format => :json, result: "success"

   assert_response :success
   assert_equal 1, JSON.parse(response.body)['invoice_id']
   assert_equal "1234567", JSON.parse(response.body)['credit_card_number']
   assert_equal "success", JSON.parse(response.body)['result']
  end

end
