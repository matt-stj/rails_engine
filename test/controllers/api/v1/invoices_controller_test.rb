require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  attr_reader :invoice

  def setup
    @invoice = Invoice.create( customer_id: 2,
    merchant_id: 4,
    status: "shipped"
    )

    3.times do |i|
      Invoice.create( customer_id: 2+i,
      merchant_id: 4+i,
      status: "shipped"
      )
    end
  end

  test "should get invoice index" do
    get :index,  :format => :json

    assert_response :success
    assert_equal 4, json_response.count
    assert_equal 2, json_response.last['customer_id']
    assert_equal "shipped", json_response.last['status']
    assert_equal 4, json_response.last['merchant_id']
  end

  test "should get invoice show page" do
    get :show,  :format => :json, id: invoice.id
    assert_response :success

    assert_equal 2, json_response['customer_id']
    assert_equal "shipped", json_response['status']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual invoice with find:id" do
    get :find,  :format => :json, id: invoice.id

    assert_response :success
    assert_equal 2, json_response['customer_id']
    assert_equal "shipped", json_response['status']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual invoice with find:cusomter_id" do
    get :find,  :format => :json, customer_id: 2

    assert_response :success
    assert_equal 2, json_response['customer_id']
    assert_equal "shipped", json_response['status']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual invoice with find:merchant_id" do
    get :find,  :format => :json, merchant_id: 4

    assert_response :success
    assert_equal 2, json_response['customer_id']
    assert_equal "shipped", json_response['status']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual invoice with find:status" do
    get :find,  :format => :json, status: "shipped"

    assert_response :success
    assert_equal 4, json_response['customer_id']
    assert_equal "shipped", json_response['status']
    assert_equal 6, json_response['merchant_id']
  end

  test "should get individual invoice with find_all:id" do
    get :find_all,  :format => :json, id: invoice.id

    assert_response :success
    assert_equal 2, json_response.first['customer_id']
    assert_equal "shipped", json_response.first['status']
    assert_equal 4, json_response.first['merchant_id']
  end

  test "should get all invoices with find_all:status" do
    get :find_all,  :format => :json, status: "shipped"

    assert_response :success
    assert json_response.first['status']
    assert_equal 4, json_response.count
  end

  test "can return a random record" do
    get :random,  :format => :json

    assert_response :success
    assert json_response['status']
  end
end
