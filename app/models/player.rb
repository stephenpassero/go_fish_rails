class Player
  attr_reader(:name, :cards, :pairs)
  def initialize(name, cards = [], pairs = [])
    @name = name
    @cards = cards
    @pairs = pairs
  end

  def cards_left
    @cards.length
  end

  def set_hand(cards)
    @cards = cards
  end

  def cards_in_hand(rank)
    @cards = @cards.select {|card| card.rank == rank}
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def remove_cards_by_rank(rank)
    @cards = @cards.select {|card| card.rank != rank}
  end

  def pair_cards
    @cards.each do |originalCard|
      sameRank = @cards.select {|card| card.rank == originalCard.rank}
      if sameRank.length == 4
        @pairs.push(sameRank[0].rank)
        @cards = @cards.select {|card| !sameRank.include?(card)}
      end
    end
  end

  def self.from_json(hash)
    Player.new(
      hash['name'],
      hash['cards'].map {|card| Card.from_json(card)},
      hash['pairs'].map {|pair| Card.from_json(pair)}
    )
  end

  def as_json
    {
      'name' => @name,
      'cards' => @cards.map {|card| card.as_json},
      'pairs' => @pairs.map {|pair| pair.as_json}
    }
  end
end
