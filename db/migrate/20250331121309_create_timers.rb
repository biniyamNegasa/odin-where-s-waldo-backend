class CreateTimers < ActiveRecord::Migration[7.2]
  def change
    create_table :timers do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :finish_time
      t.string :image_name

      t.timestamps
    end

    add_index :timers, :image_name
  end
end
