class AddBots < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :bots, :integer, default: 0
  end
end
