require 'test_helper'

class Api::V1::Customers::TransactionsControllerTest < ActionController::TestCase
  test "#index returns transactions for a given customer" do

  customer =  Customer.create!(first_name: "Matt", last_name: "Smith")
  invoice_1 = customer.invoices.create(merchant_id: 4,
    status: "shipped")
  invoice_2 = customer.invoices.create(merchant_id: 4,
      status: "shipped")

  transaction_1 = customer.invoices.first.transactions.create(invoice_id: invoice_1.id,
  credit_card_number: "1234567",
  result: "success")

  transaction_1 = customer.invoices.last.transactions.create(invoice_id: invoice_2.id,
  credit_card_number: "1234567",
  result: "success")
  
    get :index, :format => :json, customer_id: customer.id

    assert_response :success
    assert_equal 2, json_response.count
  end
end
