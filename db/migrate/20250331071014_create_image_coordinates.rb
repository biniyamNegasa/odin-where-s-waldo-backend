class CreateImageCoordinates < ActiveRecord::Migration[7.2]
  def change
    create_table :image_coordinates do |t|
      t.string :name
      t.integer :waldo, array: true, default: []
      t.integer :wenda, array: true, default: []
      t.integer :wizard, array: true, default: []
      t.integer :odlaw, array: true, default: []

      t.timestamps
    end
  end
end
