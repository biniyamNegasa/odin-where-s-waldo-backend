class AddUniqueIndexToImageCoordinatesName < ActiveRecord::Migration[7.2]
  def change
    add_index :image_coordinates, :name, unique: true
  end
end
