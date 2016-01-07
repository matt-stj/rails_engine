require 'test_helper'

class Api::V1::Transactions::InvoicesControllerTest < ActionController::TestCase
  test "#show returns invoice for a given transaction" do
    invoice = Invoice.create( customer_id: 2,
                              merchant_id: 4,
                              status: "shipped"
                              )

    transaction = Transaction.create!( invoice_id: invoice.id,
                 credit_card_number: "1234567",
                 result: "success"
               )

    get :show, :format => :json, transaction_id: transaction.id

    assert_response :success
    assert_equal invoice.id, json_response['id']
  end
end
