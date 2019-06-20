require 'rails_helper'

RSpec.describe Deck, type: :model do
  before(:each) do
    @deck = Deck.new()
  end

  it "has cards" do
    expect(@deck.cards_left).to eq(52)
  end

  it "can shuffle itself" do
    @deck.shuffle
    deck2 = Deck.new
    deck2.shuffle
    expect(@deck).to_not eq(deck2)
  end

  it "can deal cards" do
    cards = []
    cards.concat(@deck.deal(3))
    expect(cards.length).to eq(3)
  end

  describe '#as_json' do
    it 'converts an object to a hash' do
      @deck.set_deck([Card.new('5', 'Diamonds'), Card.new('J', 'Spades')])
      expect(@deck.as_json).to include_json(
        cards: [{rank: '5', suit: 'Diamonds'}, {rank: 'J', suit: 'Spades'}]
      )
    end
  end

  describe '#from_json' do
    it 'convert a hash to an object' do
      @deck.set_deck([Card.new('5', 'Diamonds'), Card.new('J', 'Spades')])
      hash = @deck.as_json
      new_deck = Deck.from_json(hash)
      expect(new_deck.cards_left).to eq(@deck.cards_left)
    end
  end

  describe 'when out of cards' do
    describe '#deal' do
      it 'doesn\'t return nil' do
        @deck.deal(52)
        dealt = @deck.deal(1)
        expect(dealt).to eq([])
      end
    end
  end
end
