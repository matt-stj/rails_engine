require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  attr_reader :item

  def setup
     5.times do |i|
       Item.create( name: "I-pod - #{i}",
                    description: "A nice thing that plays your music. - #{i}",
                    unit_price: 10000,
                    merchant_id: 4
              )
        @item = Item.first
     end
  end



  test "#index responds to json" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of items" do
    get :index, format: :json

    assert_equal Item.count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: item.id

    assert_response :success
  end

  test "#show returns a hash of a single record" do
    get :show, format: :json, id: item.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an item with the correct properties" do
    get :show, format: :json, id: item.id

    assert json_response["name"]
    assert json_response["description"]
  end

  test "should get individual item with find:id" do

    get :find,  :format => :json, id: item.id

    assert_response :success
    assert_equal "I-pod - 4", json_response['name']
    assert_equal "A nice thing that plays your music. - 4", json_response['description']
    assert_equal 10000, json_response['unit_price']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual item (case-insensitive) with find:name" do

    get :find,  :format => :json, name: "i-POD - 4"

    assert_response :success
    assert_equal "I-pod - 4", json_response['name']
    assert_equal "A nice thing that plays your music. - 4", json_response['description']
    assert_equal 10000, json_response['unit_price']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual item (case-insensitive) with find:description" do
    item = Item.create( name: "I-pod",
    description: "A nice thing that plays your music.",
    unit_price: 10000,
    merchant_id: 4
    )

    get :find,  :format => :json, description: "A niCe thIng That Plays your MusiC."

    assert_response :success
    assert_equal "I-pod", json_response['name']
    assert_equal "A nice thing that plays your music.", json_response['description']
    assert_equal 10000, json_response['unit_price']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual item with find:unit_price" do
    get :find, :format => :json, unit_price: 10000

    assert_response :success
    assert_equal "I-pod - 4", json_response['name']
    assert_equal "A nice thing that plays your music. - 4", json_response['description']
    assert_equal 10000, json_response['unit_price']
    assert_equal 4, json_response['merchant_id']
  end

  test "should get individual item with find:merchant_id" do
    get :find, :format => :json, merchant_id: 4

    assert_response :success
    assert_equal "I-pod - 4", json_response['name']
    assert_equal "A nice thing that plays your music. - 4", json_response['description']
    assert_equal 10000, json_response['unit_price']
    assert_equal 4, json_response['merchant_id']
  end
end
