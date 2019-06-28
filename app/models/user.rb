class User < ApplicationRecord
  validates :name, presence: true
  validate :name_cannot_include_bot
  has_many :game_users
  has_many :games, through: :game_users

  def name_cannot_include_bot
    errors.add(:name, 'cannot start with Bot') if name[0..2] == 'Bot'
  end
end
