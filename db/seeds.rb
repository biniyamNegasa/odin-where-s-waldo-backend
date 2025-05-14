# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

images_data = [ { name: "beach", waldo: [ 61, 38 ], wenda: [ 77, 41 ], wizard: [ 27, 36 ], odlaw: [ 10, 36 ] },
                { name: "ice",   waldo: [ 85, 74 ], wenda: [ 49, 42 ], wizard: [ 7, 77 ],  odlaw: [ 31, 64 ] },
                { name: "olympic", waldo: [ 28, 34 ], wenda: [ 25, 74 ], wizard: [ 61, 87 ], odlaw: [ 59, 65 ] },
                { name: "carpet", waldo: [ 85, 43 ], wenda: [ 48, 67 ], wizard: [ 81, 68 ], odlaw: [ 36, 80 ] },
                { name: "space", waldo: [ 40, 63 ], wenda: [ 29, 52 ], wizard: [ 78, 58 ], odlaw: [ 7, 69 ] }
              ]

images_data.each do | data |
  ImageCoordinate.find_or_create_by!(name: data[:name]) do | image_coordinate |
    image_coordinate.waldo = data[:waldo]
    image_coordinate.wenda = data[:wenda]
    image_coordinate.wizard = data[:wizard]
    image_coordinate.odlaw = data[:odlaw]
    puts "Created image coordinate #{image_coordinate.name}"
  end
end
