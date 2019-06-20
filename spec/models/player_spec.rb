require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:each) do
    @player = Player.new('Player1')
  end

  it 'has cards' do
    expect(@player.cards).to_not eq(nil)
  end

  it 'can add cards it its hand' do
    card1 = Card.new('3', 'Diamonds')
    card2 = Card.new('J', 'Clubs')
    @player.add_cards([card1, card2])
    expect(@player.cards).to eq([card1, card2])
  end

  it 'can find all cards of a certain rank in its hand' do
    card1 = Card.new('6', 'Hearts')
    card2 = Card.new('K', 'Clubs')
    card3 = Card.new('6', 'Spades')
    @player.set_hand([card1, card2, card3])
    expect(@player.cards_in_hand('6')).to eq([card1, card3])
  end

  it 'can remove cards from its hand' do
    card1 = Card.new('6', 'Hearts')
    card2 = Card.new('K', 'Clubs')
    card3 = Card.new('6', 'Spades')
    @player.set_hand([card1, card2, card3])
    @player.remove_cards_by_rank('6')
    expect(@player.cards).to eq([card2])
  end

  it 'can pair four cards of the same rank' do
    card1 = Card.new('6', 'Hearts')
    card2 = Card.new('6', 'Clubs')
    card3 = Card.new('6', 'Spades')
    card4 = Card.new('6', 'Diamonds')
    @player.set_hand([card1, card2, card3, card4])
    @player.pair_cards
    expect(@player.cards_left).to eq(0)
    expect(@player.pairs).to eq(['6'])
  end

  describe '#as_json' do
    it 'converts an object into a hash' do
      @player.set_hand([Card.new('A', 'Spades'), Card.new('A', 'Diamonds')])
      expect(@player.as_json).to include_json(
        name: 'Player1',
        cards: [{rank: 'A', suit: 'Spades'}, {rank: 'A', suit: 'Diamonds'}],
        pairs: []
      )
    end
  end

  describe '#from_json' do
    it 'converts an hash into an object' do
      @player.set_hand([Card.new('A', 'Spades'), Card.new('A', 'Diamonds')])
      new_player = Player.from_json(@player.as_json)
      expect(new_player.name).to eq(@player.name)
      expect(new_player.cards[0].suit).to eq(@player.cards[0].suit)
    end
  end
end
