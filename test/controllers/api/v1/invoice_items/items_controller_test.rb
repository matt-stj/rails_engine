require 'test_helper'

class Api::V1::InvoiceItems::ItemsControllerTest < ActionController::TestCase
  test "#show returns item for a given invoice_item" do
    invoice_item =  InvoiceItem.create( item_id: 2,
                   invoice_id: 4,
                   quantity: 1,
                   unit_price: 3
             )

      get :show, :format => :json, invoice_item_id: invoice_item.id

    assert_response :success
  end
end
