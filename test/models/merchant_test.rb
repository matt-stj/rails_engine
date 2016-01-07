require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "a merchant has proper attributes" do
    merchant = Merchant.create(name: "Turing")
    assert_equal "Turing", merchant.name
  end

  should have_many(:items)
  should have_many(:invoices)
  should have_many(:invoice_items)
  should have_many(:transactions)

end
