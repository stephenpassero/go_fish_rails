require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:each) do
    @player = Player.new(name: 'Player1')
  end

  it 'has cards' do
    expect(@player.cards).to_not eq(nil)
  end

  it 'can add cards it its hand' do
    card1 = Card.new(rank: '3', suit: 'Diamonds')
    card2 = Card.new(rank: 'J', suit: 'Clubs')
    @player.add_cards([card1, card2])
    expect(@player.cards).to eq([card1, card2])
  end

  it 'can find all cards of a certain rank in its hand' do
    card1 = Card.new(rank: '6', suit: 'Hearts')
    card2 = Card.new(rank: 'K', suit: 'Clubs')
    card3 = Card.new(rank: '6', suit: 'Spades')
    @player.set_hand([card1, card2, card3])
    expect(@player.cards_in_hand('6')).to eq([card1, card3])
  end

  it 'can remove cards from its hand' do
    card1 = Card.new(rank: '6', suit: 'Hearts')
    card2 = Card.new(rank: 'K', suit: 'Clubs')
    card3 = Card.new(rank: '6', suit: 'Spades')
    @player.set_hand([card1, card2, card3])
    @player.remove_cards_by_rank('6')
    expect(@player.cards).to eq([card2])
  end

  it 'can pair four cards of the same rank' do
    card1 = Card.new(rank: '6', suit: 'Hearts')
    card2 = Card.new(rank: '6', suit: 'Clubs')
    card3 = Card.new(rank: '6', suit: 'Spades')
    card4 = Card.new(rank: '6', suit: 'Diamonds')
    @player.set_hand([card1, card2, card3, card4])
    @player.pair_cards
    expect(@player.cards_left).to eq(0)
    expect(@player.pairs).to eq(['6'])
  end

  describe '#as_json' do
    it 'converts an object into a hash' do
      @player.set_hand([Card.new(rank: 'A', suit: 'Spades'), Card.new(rank: 'A', suit: 'Diamonds')])
      expect(@player.as_json).to include_json(
        name: 'Player1',
        cards: [{rank: 'A', suit: 'Spades'}, {rank: 'A', suit: 'Diamonds'}],
        pairs: []
      )
    end
  end

  # Add tests for pairs
  describe '#as_opponent_json' do
    it 'converts an object into a hash of only the necessary data' do
      @player.set_hand([Card.new(rank: 'A', suit: 'Spades'), Card.new(rank: 'A', suit: 'Diamonds')])
      expect(@player.as_opponent_json).to include_json(
        name: 'Player1',
        cards_left: 2,
        pairs: []
      )
    end
  end

  describe '#from_json' do
    it 'converts an hash into an object' do
      @player.set_hand([Card.new(rank: 'A', suit: 'Spades'), Card.new(rank: 'A', suit: 'Diamonds')])
      new_player = Player.from_json(@player.as_json)
      expect(new_player.name).to eq(@player.name)
      expect(new_player.cards[0].suit).to eq(@player.cards[0].suit)
    end
  end
end
