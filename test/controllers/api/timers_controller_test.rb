require "test_helper"

class Api::TimersControllerTest < ActionDispatch::IntegrationTest
  test "create starts a new timer" do
    assert_difference("Timer.count") do
      post api_timers_url, params: { timer: { name: "Carol", image_name: "beach" } }
    end

    assert_response :created
    assert_not_nil response.parsed_body["start_time"]
    assert_equal [], response.parsed_body["found_characters"]
  end

  test "create rejects invalid usernames" do
    [ "", "ab", "1abc", "ab cd", "a" * 21 ].each do |bad_name|
      post api_timers_url, params: { timer: { name: bad_name, image_name: "beach" } }
      assert_response :unprocessable_entity, "expected #{bad_name.inspect} to be rejected"
    end
  end

  test "create rejects unknown image" do
    post api_timers_url, params: { timer: { name: "Carol", image_name: "atlantis" } }
    assert_response :unprocessable_entity
  end

  test "check finds character at correct coordinates and records it" do
    timer = timers(:running)
    post check_api_timer_url(timer), params: { who: "waldo", coord: "61,38" }

    assert_response :success
    body = response.parsed_body
    assert_equal true, body["found"]
    assert_includes body["found_characters"], "waldo"
    assert_equal false, body["all_found"]
    assert_includes timer.reload.found_characters, "waldo"
  end

  test "check accepts coordinates within tolerance" do
    post check_api_timer_url(timers(:running)), params: { who: "waldo", coord: "63.4,40.1" }
    assert_response :success
    assert_equal true, response.parsed_body["found"]
  end

  test "check does not record wrong coordinates" do
    timer = timers(:running)
    post check_api_timer_url(timer), params: { who: "waldo", coord: "1,1" }

    assert_response :success
    assert_equal false, response.parsed_body["found"]
    assert_empty timer.reload.found_characters
  end

  test "check reports all_found on the last character" do
    post check_api_timer_url(timers(:almost_done)), params: { who: "odlaw", coord: "10,36" }

    assert_response :success
    assert_equal true, response.parsed_body["all_found"]
  end

  test "check rejects invalid who, missing coord, finished timer, unknown timer" do
    post check_api_timer_url(timers(:running)), params: { who: "batman", coord: "1,1" }
    assert_response :unprocessable_entity

    post check_api_timer_url(timers(:running)), params: { who: "waldo" }
    assert_response :bad_request

    post check_api_timer_url(timers(:finished)), params: { who: "waldo", coord: "61,38" }
    assert_response :unprocessable_entity

    post check_api_timer_url(id: 0), params: { who: "waldo", coord: "61,38" }
    assert_response :not_found
  end

  test "update refuses to finish until all characters are found" do
    patch api_timer_url(timers(:running))
    assert_response :unprocessable_entity
    assert_match(/Not all characters/, response.parsed_body["error"])

    patch api_timer_url(timers(:almost_done))
    assert_response :unprocessable_entity
  end

  test "update finishes a timer once every character is recorded" do
    timer = timers(:almost_done)
    post check_api_timer_url(timer), params: { who: "odlaw", coord: "10,36" }

    patch api_timer_url(timer)
    assert_response :ok
    assert response.parsed_body.key?("time_taken")
  end

  test "update rejects an already finished timer" do
    patch api_timer_url(timers(:finished))
    assert_response :unprocessable_entity
    assert_equal "Game already finished", response.parsed_body["error"]
  end

  test "update returns not found for unknown timer" do
    patch api_timer_url(id: 0)
    assert_response :not_found
  end

  test "full game flow: create, find everyone, finish" do
    post api_timers_url, params: { timer: { name: "Player1", image_name: "beach" } }
    assert_response :created
    id = response.parsed_body["id"]

    { "waldo" => "61,38", "wenda" => "77,41", "wizard" => "27,36", "odlaw" => "10,36" }.each do |who, coord|
      post check_api_timer_url(id: id), params: { who: who, coord: coord }
      assert_response :success
      assert_equal true, response.parsed_body["found"]
    end

    patch api_timer_url(id: id)
    assert_response :ok
    assert_kind_of Numeric, response.parsed_body["time_taken"]
  end
end
