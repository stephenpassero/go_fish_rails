class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  scope :pending, -> {where(start_at: nil)}
  scope :in_progress, -> {where.not(start_at: nil).where(end_at: nil)}
  validates :bots, numericality: {less_than: :players}

  serialize :game_logic, GameLogic

  # Pass bots to the GameLogic here too
  def start()
    game_logic_class = GameLogic.new(player_names: users.map(&:name), bots: bots)
    game_logic_class.start_game
    update(game_logic: game_logic_class, start_at: Time.now)
  end

  def waiting_for_players
    players - bots - users.length
  end
end
