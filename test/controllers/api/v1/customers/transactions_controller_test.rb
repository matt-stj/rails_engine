require 'test_helper'

class Api::V1::Customers::TransactionsControllerTest < ActionController::TestCase
  test "#index returns transactions for a given customer" do

  customer =   Customer.create!(first_name: "Matt", last_name: "Smith")

    get :index, :format => :json, customer_id: customer.id

    assert_response :success
  end
end
