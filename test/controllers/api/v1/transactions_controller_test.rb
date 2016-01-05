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
end
