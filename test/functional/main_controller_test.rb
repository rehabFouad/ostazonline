require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get balance_sheet" do
    get :balance_sheet
    assert_response :success
  end

end
