# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

images_data = [ { name: "beach", waldo: [ 503, 205 ], wenda: [ 629, 218 ], wizard: [ 221, 191 ], odlaw: [ 86, 193 ] } ]

images_data.each do | data |
  ImageCoordinate.find_or_create_by!(name: data[:name]) do | image_coordinate |
    image_coordinate.waldo = data[:waldo]
    image_coordinate.wenda = data[:wenda]
    image_coordinate.wizard = data[:wizard]
    image_coordinate.odlaw = data[:odlaw]
    puts "Created image coordinate #{image_coordinate.name}"
  end
end
