require 'test_helper'

class Api::V1::Merchants::FavoriteCustomersControllerTest < ActionController::TestCase
  attr_reader :merchant, :favorite_customer

  def setup
    @favorite_customer = Customer.create!(first_name: "Happy", last_name: "Customer")
    @merchant = Merchant.create!(name: "Turing")

    least_favorite_customer = Customer.create!(first_name: "Sad", last_name: "Customer")

    items = 5.times do |i|
        Item.create( name: "I-pod - #{i}",
        description: "A nice thing that plays your music. - #{i}",
        unit_price: 10,
        merchant_id: merchant.id
        )
      end

    3.times do |i|
      favorite_customer.invoices.create!( customer_id: favorite_customer.id,
        merchant_id: merchant.id,
        status: "shipped"
        )
      end

      least_favorite_customer.invoices.create!(merchant_id: merchant.id,
        status: "shipped"
        )

    3.times do |i|
        InvoiceItem.create( item_id: Item.first.id,
          invoice_id: (Invoice.last.id - i),
          quantity: 1,
          unit_price: 10
          )
    end

    3.times do |i|
      Transaction.create( invoice_id: (Invoice.last.id - i),
        credit_card_number: "1234567",
        result: "success")
    end

  end

  test "#show returns customer with most transactions" do
      get :show, :format => :json, merchant_id: merchant.id

      assert_response :success
      assert_equal "Happy", json_response['first_name']
      assert_equal "Customer", json_response['last_name']
  end
end
