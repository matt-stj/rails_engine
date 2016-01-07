require 'test_helper'

class Api::V1::Merchants::MostRevenueControllerTest < ActionController::TestCase
  test "#index endpoint returns array" do
    get :index, :format => :json

    assert_response :success
    assert_kind_of Array, json_response
  end
end
