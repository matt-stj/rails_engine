require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "a transaction has proper attributes" do
    transaction = Transaction.create( invoice_id: 1,
    credit_card_number: "1234567",
    result: "success"
    )

    assert_equal 1, transaction.invoice_id
    assert_equal "1234567", transaction.credit_card_number
    assert_equal "success", transaction.result
  end

  should belong_to(:invoice)
end
