require 'test_helper'

class Api::V1::Customers::InvoicesControllerTest < ActionController::TestCase
  test "#index returns invoices for a given customer" do

  customer =  Customer.create!(first_name: "Matt", last_name: "Smith")

  5.times do |i|
    customer.invoices.create(merchant_id: 4,
    status: "shipped")
  end

    get :index, :format => :json, customer_id: customer.id

    assert_response :success
    assert_equal 5, json_response.count
  end
end
