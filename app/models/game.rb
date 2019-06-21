class Game < ApplicationRecord
  has_many :users
  scope :pending, -> {where(start_at: nil)}
  scope :in_progress, -> {where.not(start_at: nil).where(end_at: nil)}

  serialize :game_logic, GameLogic

  def start()
    gameLogic = GameLogic.new(users.map {|user| user.name})
    gameLogic.start_game
    self.game_logic = gameLogic
    binding.pry
  end
end
