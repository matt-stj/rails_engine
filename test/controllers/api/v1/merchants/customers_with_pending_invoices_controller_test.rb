require 'test_helper'

class Api::V1::Merchants::CustomersWithPendingInvoicesControllerTest < ActionController::TestCase
  attr_reader :merchant, :customer

  def setup
    @customer = Customer.create!(first_name: "Matt", last_name: "Smith")
    @merchant = Merchant.create!(name: "Turing")

    failed_customer = Customer.create!(first_name: "Sad", last_name: "Customer")

    items = 5.times do |i|
        Item.create( name: "I-pod - #{i}",
        description: "A nice thing that plays your music. - #{i}",
        unit_price: 10,
        merchant_id: merchant.id
        )
      end

    successful_invoice = Invoice.create!( customer_id: customer.id,
      merchant_id: merchant.id,
      status: "shipped"
      )

    failed_invoice = Invoice.create!( customer_id: failed_customer.id,
      merchant_id: merchant.id,
      status: "not-shipped"
      )

    invoice_items = 3.times do |i|
        InvoiceItem.create( item_id: Item.first.id,
          invoice_id: successful_invoice.id,
          quantity: 1,
          unit_price: 10
          )
    end

    transaction =Transaction.create( invoice_id: successful_invoice.id,
        credit_card_number: "1234567",
        result: "success")

    failed_transaction = Transaction.create(invoice_id: failed_invoice.id,
      credit_card_number: "1234567",
      result: "failed")
  end

  test "#index returns customers with outstanding payments" do
      get :index, :format => :json, merchant_id: Merchant.first

      assert_response :success
      assert_equal "Sad", json_response.first['first_name']
      assert_equal "Customer", json_response.first['last_name']
  end
end
