class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> {where(start_at: nil)}
  scope :in_progress, -> {where.not(start_at: nil).where(end_at: nil)}
  validates :bots, numericality: {less_than: :players}

  serialize :game_logic, GameLogic

  def start()
    binding.pry
    # Make the game create bots
    game_logic_class = GameLogic.new(player_names: users.map(&:name))
    game_logic_class.start_game
    update(game_logic: game_logic_class, start_at: Time.now)
  end
end
