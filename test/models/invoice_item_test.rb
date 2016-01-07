require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test "An Invoice Item has proper attributes" do
    invoice_item = InvoiceItem.new(
                                    item_id: 1,
                                    invoice_id: 2,
                                    quantity: 5,
                                    unit_price: 3
    )

    assert_equal 1, invoice_item.item_id
    assert_equal 2, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 3, invoice_item.unit_price
  end

  should belong_to(:invoice)
  should belong_to(:item)
end
