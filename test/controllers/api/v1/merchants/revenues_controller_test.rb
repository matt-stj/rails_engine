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

    invoice_items = 3.times do |i|
        InvoiceItem.create( item_id: Item.first.id,
          invoice_id: invoice.id,
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
      get :show, :format => :json, merchant_id: Merchant.first

      assert_response :success
      assert_equal ({"revenue" => "30.0"}), json_response
  end

  test "#show with a date parameter returns the total transactional revenue for given merchant in a certain day" do
      get :show, :format => :json, merchant_id: Merchant.first, date: Transaction.first.created_at.strftime("%m-%d-%y %l:%M:%S")

      assert_response :success
      assert_equal ({"revenue" => "0.0"}), json_response
  end
end
