require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  attr_reader :transaction

  def setup
    @transaction = Transaction.create( invoice_id: 1,
    credit_card_number: "1234567",
    result: "success"
    )
    3.times do |i|
      Transaction.create( invoice_id: 1+i,
      credit_card_number: "1234567#{i}",
      result: "success"
      )
    end
  end

  test "should get transactions index" do
    get :index,  :format => :json

    assert_response :success
    assert_equal 4, json_response.count
    assert_equal 1, json_response.last['invoice_id']
    assert_equal "1234567", json_response.last['credit_card_number']
    assert_equal "success", json_response.last['result']
  end

  test "should get transactions show page" do

    get :show,  :format => :json, id: transaction.id

    assert_response :success
    assert_equal 1, json_response['invoice_id']
    assert_equal "1234567", json_response['credit_card_number']
    assert_equal "success", json_response['result']
  end

  test "should get single record for find:id" do

    get :find,  :format => :json, id: transaction.id

    assert_response :success
    assert_equal 1, json_response['invoice_id']
    assert_equal "1234567", json_response['credit_card_number']
    assert_equal "success", json_response['result']
  end

  test "should get single record for find:credit_card_number" do

    get :find,  :format => :json, credit_card_number: "1234567"

    assert_response :success
    assert_equal 1, json_response['invoice_id']
    assert_equal "1234567", json_response['credit_card_number']
    assert_equal "success", json_response['result']
  end

  test "should get single record (case-insensitive) for find:result" do

    get :find,  :format => :json, result: "success"

    assert_response :success
    assert_equal 3, json_response['invoice_id']
  end

  test "#find_all should return all matching objects for find:result" do
    get :find_all,  :format => :json, result: "success"

    assert_response :success
    assert_equal 4, json_response.count
  end

  test "#find_all should return all matching objects for find:credit_card" do
    get :find_all,  :format => :json, credit_card_number: "1234567"

    assert_response :success
    assert_equal "1234567", json_response.first['credit_card_number']
  end

  test "# random will return a random record" do
    get :random,  :format => :json

    assert_response :success
    assert json_response['credit_card_number']
   end

end
