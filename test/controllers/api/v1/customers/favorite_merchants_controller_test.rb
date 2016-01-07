require 'test_helper'

class Api::V1::Customers::FavoriteMerchantsControllerTest < ActionController::TestCase
  attr_reader :customer

  def setup
    @customer = Customer.create!(first_name: "Happy", last_name: "Customer")
    favorite_merchant = Merchant.create!(name: "Turing")
    least_favorite_merchant = Merchant.create!(name: "G-School")


    items = 5.times do |i|
        Item.create( name: "I-pod - #{i}",
        description: "A nice thing that plays your music. - #{i}",
        unit_price: 10,
        merchant_id: favorite_merchant.id
        )
      end

    3.times do |i|
      customer.invoices.create!( customer_id: customer.id,
        merchant_id: favorite_merchant.id,
        status: "shipped"
        )
      end

      least_favorite_merchant.invoices.create!(merchant_id: favorite_merchant.id,
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

  test "#show returns most purchased-from merchant" do
      get :show, :format => :json, customer_id: customer.id

      assert_response :success
      assert_equal "Turing", json_response['name']
  end
end
