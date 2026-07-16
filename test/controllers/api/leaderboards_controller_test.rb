require "test_helper"

class Api::LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  test "returns only completed timers for the image" do
    get api_leaderboard_url(image_name: "beach")
    assert_response :success

    entries = response.parsed_body
    assert_equal 1, entries.length
    assert_equal "Alice", entries.first["name"]
    assert_equal 90, entries.first["time_taken"]
  end

  test "returns empty list for a known image with no scores" do
    get api_leaderboard_url(image_name: "ice")
    assert_response :success
    assert_equal [], response.parsed_body
  end

  test "returns 404 for an unknown image" do
    get api_leaderboard_url(image_name: "nonexistent")
    assert_response :not_found
  end
end
