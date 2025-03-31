# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

images_data = [ { name: "beach", waldo: [ 503, 205 ], wenda: [ 629, 218 ], wizard: [ 221, 191 ], odlaw: [ 86, 193 ] },
                { name: "ice",   waldo: [ 696, 386 ], wenda: [ 398, 223 ], wizard: [ 59, 399 ],  odlaw: [ 257, 334 ] },
                { name: "olympic", waldo: [ 229, 181 ], wenda: [ 204, 380 ], wizard: [ 499, 456 ], odlaw: [ 487, 341 ] },
                { name: "carpet", waldo: [ 701, 781 ], wenda: [ 393, 1199 ], wizard: [ 665, 1213 ], odlaw: [ 295, 1422 ] },
                { name: "space", waldo: [ 329, 340 ], wenda: [ 239, 284 ], wizard: [ 635, 315 ], odlaw: [ 58, 374 ] }
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
