require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "A customer has valid attributes" do
    customer = Customer.new( first_name: "Matt",
                             last_name: "Smith"
    )

    assert_equal "Matt", customer.first_name
    assert_equal "Smith", customer.last_name
  end

  should have_many(:invoices)
  should have_many(:transactions)
end
