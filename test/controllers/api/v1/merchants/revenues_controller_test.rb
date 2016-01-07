require 'test_helper'

class Api::V1::Merchants::RevenuesControllerTest < ActionController::TestCase
  attr_reader :merchant, :customer

  def setup
    @customer = Customer.create!(first_name: "Matt", last_name: "Smith")
    @merchant = Merchant.create!(name: "Turing")

    items = 5.times do |i|
        Item.create( name: "I-pod - #{i}",
        description: "A nice thing that plays your music. - #{i}",
        unit_price: 10,
        merchant_id: merchant.id
        )
      end

    invoice = Invoice.create!( customer_id: customer.id,
      merchant_id: merchant.id,
      status: "shipped"
      )
    end

    invoice_items = 3.times do |i|
        InvoiceItem.create( item_id: Item.find(Item.first.id),
          invoice_id: invoices[i],
          quantity: 1,
          unit_price: 10
          )
    end

    transaction =Transaction.create( invoice_id: Invoice.first.id,
        credit_card_number: "1234567",
        result: "success")

    failed_transaction = Transaction.create(invoice_id: Invoice.first.id,
      credit_card_number: "1234567",
      result: "failed")
  end

  test "#show returns the total transactional revenue for given merchant" do
      get :show, :format => :json, merchant_id: merchant.id

      assert_response :success
      binding.pry
  end
end
