class Card
  attr_reader(:rank, :suit)
  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
  end

  def self.from_json(hash)
    Card.new(rank: hash['rank'], suit: hash['suit'])
  end

  def as_json
    {'rank'=> rank, 'suit'=> suit}
  end
end
