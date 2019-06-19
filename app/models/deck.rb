require 'rails_helper'

class Deck
  attr_reader(:cards)
  def initialize
    ranks = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'J', 'K']
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    @cards = []
    ranks.each do |rank|
      suits.each do |suit|
        card = Card.new(rank, suit)
        @cards.push(card)
      end
    end
  end

  def cards_left
    @cards.length
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(num_of_cards)
    temporary_cards = []
    num_of_cards.times do
      temporary_cards.push(@cards.pop())
    end
    temporary_cards
  end
end
