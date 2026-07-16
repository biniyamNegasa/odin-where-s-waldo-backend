class ImageCoordinate < ApplicationRecord
  TOLERANCE = 3
  COORD_FORMAT = /\A-?\d+(\.\d+)?,-?\d+(\.\d+)?\z/

  validates :name, presence: true, uniqueness: true

  # coord is a "x,y" string of percent values, e.g. "61.4,38.2"
  def character_at?(character, coord)
    target = public_send(character)
    return false unless target.is_a?(Array) && target.length == 2
    return false unless coord.to_s.match?(COORD_FORMAT)

    x, y = coord.split(",").map(&:to_f)
    (x - target[0]).abs <= TOLERANCE && (y - target[1]).abs <= TOLERANCE
  end
end
