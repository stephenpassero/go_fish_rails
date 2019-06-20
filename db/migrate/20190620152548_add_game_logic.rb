class AddGameLogic < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :game_logic, :jsonb, null: false, default: {}
  end
end
