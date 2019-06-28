class Player
  attr_reader(:name, :cards, :pairs, :bot)
  def initialize(name:, cards: [], pairs: [], bot: false)
    @name = name
    @cards = cards
    @pairs = pairs
    @bot = bot
  end

  def cards_left
    cards.length
  end

  def set_hand(cards)
    @cards = cards
  end

  def cards_in_hand(rank)
    cards.select {|card| card.rank == rank}
  end

  def get_target(players)
    names = players.map(&:name).select {|player_name| player_name != name}
    names.sample
  end

  def get_rank
    cards.map(&:rank).sample
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def remove_cards_by_rank(rank)
    @cards = @cards.select {|card| card.rank != rank}
  end

  def pair_cards
    paired = nil
    @cards.each do |originalCard|
      sameRank = cards.select {|card| card.rank == originalCard.rank}
      if sameRank.length == 4
        @pairs.push(Card.new(rank: sameRank[0].rank, suit: 'Spades'))
        paired = sameRank[0].rank
        @cards = @cards.select {|card| !sameRank.include?(card)}
      end
    end
    paired
  end

  def self.from_json(hash)
    Player.new(
      name: hash['name'],
      cards: hash['cards'].map {|card| Card.from_json(card)},
      pairs: hash['pairs'].map {|pair| Card.from_json(pair)},
      bot: hash['bot']
    )
  end

  def as_opponent_json
    {
      'name' => name,
      'cards_left' => cards.length,
      'pairs' => pairs.map(&:as_json),
      'bot' => bot
    }
  end

  def as_json
    {
      'name' => name,
      'cards' => cards.map(&:as_json),
      'pairs' => pairs.map(&:as_json),
      'bot' => bot
    }
  end
end
