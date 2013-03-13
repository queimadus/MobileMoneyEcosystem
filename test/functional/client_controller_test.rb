require 'test_helper'

class ClientControllerTest < ActionController::TestCase
  test "should get consult" do
    get :consult
    assert_response :success
  end

end
