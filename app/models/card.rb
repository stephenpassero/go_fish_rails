class Card
  attr_reader(:rank, :suit)
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def self.from_json(hash)
    Card.new(hash[:rank], hash[:suit])
  end

  def as_json
    {rank: self.rank, suit: self.suit}
  end
end
