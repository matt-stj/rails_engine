require 'test_helper'

class Api::V1::Transactions::InvoicesControllerTest < ActionController::TestCase
  test "#show returns invoice for a given transaction" do

    transaction = Transaction.create( invoice_id: 1,
                 credit_card_number: "1234567",
                 result: "success"
               )


    get :show, :format => :json, transaction_id: transaction.id

    assert_response :success
  end
end
