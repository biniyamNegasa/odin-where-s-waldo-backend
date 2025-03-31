require "test_helper"

class Api::LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_leaderboards_show_url
    assert_response :success
  end
end
