class CreateImageCoordinates < ActiveRecord::Migration[7.2]
  def change
    create_table :image_coordinates do |t|
      t.string :name
      t.json :waldo, default: []
      t.json :wenda, default: []
      t.json :wizard, default: []
      t.json :odlaw, default: []

      t.timestamps
    end
  end
end
