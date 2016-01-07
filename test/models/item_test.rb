require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "an item has the correct attributes" do
    item =  Item.create( name: "I-pod",
            description: "A nice thing that plays your music.",
            unit_price: 10000,
            merchant_id: 4
            )
    assert_equal "I-pod", item.name
    assert_equal "A nice thing that plays your music.", item.description
    assert_equal 10000, item.unit_price
    assert_equal 4, item.merchant_id
  end

  should belong_to(:merchant)
  should have_many(:invoice_items)
  should have_many(:invoices)

end
