class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> {where(start_at: nil)}
  scope :in_progress, -> {where.not(start_at: nil).where(end_at: nil)}

  serialize :game_logic, GameLogic

  def start()
    game_logic_class = GameLogic.new(player_names: users.map(&:name))
    game_logic_class.start_game
    update(game_logic: game_logic_class)
  end
end
