require "test_helper"

class ImageCoordinateTest < ActiveSupport::TestCase
  # beach fixture: waldo at [61, 38]
  test "character_at? matches exact and within-tolerance coordinates" do
    beach = image_coordinates(:one)
    assert beach.character_at?("waldo", "61,38")
    assert beach.character_at?("waldo", "63.9,40.9")
    assert_not beach.character_at?("waldo", "64.1,38")
    assert_not beach.character_at?("waldo", "1,1")
  end

  test "character_at? rejects malformed coordinates" do
    beach = image_coordinates(:one)
    [ nil, "", "61", "61,38,12", "abc,def", "61;38" ].each do |bad|
      assert_not beach.character_at?("waldo", bad), "expected #{bad.inspect} to be rejected"
    end
  end

  test "name must be unique" do
    duplicate = ImageCoordinate.new(name: "beach")
    assert_not duplicate.valid?
  end
end
