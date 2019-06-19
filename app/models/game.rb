class Game < ApplicationRecord
  has_many :users
  scope :pending, -> {where(start_at: nil)}
  scope :in_progress, -> {where.not(start_at: nil).where(end_at: nil)}
end
