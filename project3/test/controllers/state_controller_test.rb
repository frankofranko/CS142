require 'test_helper'

class StateControllerTest < ActionController::TestCase
  test "should get filter" do
    get :filter
    assert_response :success
  end

end
