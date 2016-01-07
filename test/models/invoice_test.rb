require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "An invoice has proper attributes" do
    invoice = Invoice.create( customer_id: 2,
    merchant_id: 4,
    status: "shipped")

    assert_equal 2, invoice.customer_id
    assert_equal 4, invoice.merchant_id
    assert_equal "shipped", invoice.status
  end

  should belong_to(:merchant)
  should belong_to(:customer)
  should have_many(:transactions)
  should have_many(:invoice_items)
  should have_many(:items)
end
