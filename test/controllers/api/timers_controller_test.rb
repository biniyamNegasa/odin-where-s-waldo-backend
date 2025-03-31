require "test_helper"

class Api::TimersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_timers_create_url
    assert_response :success
  end

  test "should get update" do
    get api_timers_update_url
    assert_response :success
  end
end
