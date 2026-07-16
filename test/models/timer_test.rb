require "test_helper"

class TimerTest < ActiveSupport::TestCase
  def build_timer(**overrides)
    Timer.new({ name: "Alice", image_name: "beach", start_time: Time.current }.merge(overrides))
  end

  test "valid with proper attributes" do
    assert_predicate build_timer, :valid?
  end

  test "rejects bad usernames" do
    [ nil, "", "ab", "9abc", "ab-cd", "a" * 21 ].each do |bad|
      assert_not build_timer(name: bad).valid?, "expected #{bad.inspect} to be invalid"
    end
  end

  test "rejects unknown image names" do
    assert_not build_timer(image_name: "atlantis").valid?
  end

  test "duration is nil while running, rounded when finished, clamped at zero" do
    start = Time.current
    assert_nil build_timer(start_time: start).duration
    assert_equal 90.13, build_timer(start_time: start, finish_time: start + 90.126).duration
    assert_equal 0, build_timer(start_time: start, finish_time: start - 5).duration
  end

  test "record_found adds a character once" do
    timer = timers(:running)
    timer.record_found("waldo")
    timer.record_found("waldo")
    assert_equal [ "waldo" ], timer.reload.found_characters
  end

  test "all_found? requires every character" do
    assert timers(:finished).all_found?
    assert_not timers(:almost_done).all_found?
  end

  test "abandoned scope matches old unfinished timers only" do
    old_unfinished = Timer.create!(name: "Old", image_name: "beach",
      start_time: 2.days.ago, created_at: 2.days.ago)

    assert_includes Timer.abandoned, old_unfinished
    assert_not_includes Timer.abandoned, timers(:running)
    assert_not_includes Timer.abandoned, timers(:finished)
  end
end
