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
