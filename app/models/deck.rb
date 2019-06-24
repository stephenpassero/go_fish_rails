class Deck
  attr_reader(:cards)
  def initialize(cards: [])
    ranks = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'J', 'K']
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    @cards = cards
    if @cards.length == 0
      ranks.each do |rank|
        suits.each do |suit|
          card = Card.new(rank: rank, suit: suit)
          @cards.push(card)
        end
      end
    end
  end

  def cards_left
    cards.length
  end

  def shuffle
    @cards.shuffle!
  end

  def set_deck(cards)
    @cards = cards
  end

  def deal(num_of_cards)
    temporary_cards = []
    num_of_cards.times do
      temporary_cards.push(@cards.pop())
    end
    temporary_cards - [nil]
  end

  def self.from_json(hash)
    Deck.new(cards: hash['cards'].map {|card| Card.from_json(card)})
  end

  def game_as_json
    {'cards' => cards.length}
  end

  def as_json
    {'cards' => cards.map(&:as_json)}
  end
end
