require 'test_helper'

class Api::V1::Invoices::TransactionsControllerTest < ActionController::TestCase
  attr_reader :invoice, :transaction
  def setup
    @invoice = Invoice.create( customer_id: 2,
                 merchant_id: 4,
                 status: "shipped"
           )
    @transaction = invoice.transactions.create( invoice_id: 1,
                     credit_card_number: "1234567",
                     result: "success"
                   )
  end

  test "#index returns all transactions for a given invoice" do
    get :index, :format => :json, invoice_id: invoice.id

    assert_response :success
    assert_equal transaction.id, json_response.first['id']
  end
end
