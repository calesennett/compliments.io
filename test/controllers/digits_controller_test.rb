require 'test_helper'

class DigitsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get digits_create_url
    assert_response :success
  end

end
