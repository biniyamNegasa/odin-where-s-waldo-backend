class AddFoundCharactersToTimers < ActiveRecord::Migration[7.2]
  def change
    add_column :timers, :found_characters, :json, default: [], null: false
  end
end
