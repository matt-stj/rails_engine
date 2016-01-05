require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "should get items index" do
     get :index,  :format => :json
     assert_response :success

     assert_equal "[]", response.body

     Item.create( name: "I-pod",
                  description: "A nice thing that plays your music.",
                  unit_price: 10000,
                  merchant_id: 4
            )

     get :index,  :format => :json

     assert_response :success
     assert_equal "I-pod", JSON.parse(response.body).first['name']
     assert_equal "A nice thing that plays your music.", JSON.parse(response.body).first['description']
     assert_equal 10000, JSON.parse(response.body).first['unit_price']
     assert_equal 4, JSON.parse(response.body).first['merchant_id']
   end

   test "should get individual item with find:id" do
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    get :find,  :format => :json, id: item.id

    assert_response :success
    assert_equal "I-pod", JSON.parse(response.body)['name']
    assert_equal "A nice thing that plays your music.", JSON.parse(response.body)['description']
    assert_equal 10000, JSON.parse(response.body)['unit_price']
    assert_equal 4, JSON.parse(response.body)['merchant_id']
  end

  test "should get individual item (case-insensitive) with find:name" do
   item = Item.create( name: "I-pod",
                description: "A nice thing that plays your music.",
                unit_price: 10000,
                merchant_id: 4
          )

   get :find,  :format => :json, name: "i-POD"

   assert_response :success
   assert_equal "I-pod", JSON.parse(response.body)['name']
   assert_equal "A nice thing that plays your music.", JSON.parse(response.body)['description']
   assert_equal 10000, JSON.parse(response.body)['unit_price']
   assert_equal 4, JSON.parse(response.body)['merchant_id']
 end

  test "should get individual item (case-insensitive) with find:description" do
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    get :find,  :format => :json, description: "A niCe thIng That Plays your MusiC."

    assert_response :success
    assert_equal "I-pod", JSON.parse(response.body)['name']
    assert_equal "A nice thing that plays your music.", JSON.parse(response.body)['description']
    assert_equal 10000, JSON.parse(response.body)['unit_price']
    assert_equal 4, JSON.parse(response.body)['merchant_id']
  end

  test "should get individual item with find:unit_price" do
    item = Item.create( name: "I-pod",
                 description: "A nice thing that plays your music.",
                 unit_price: 10000,
                 merchant_id: 4
           )

    get :find, :format => :json, unit_price: 10000

    assert_response :success
    assert_equal "I-pod", JSON.parse(response.body)['name']
    assert_equal "A nice thing that plays your music.", JSON.parse(response.body)['description']
    assert_equal 10000, JSON.parse(response.body)['unit_price']
    assert_equal 4, JSON.parse(response.body)['merchant_id']
  end
end
