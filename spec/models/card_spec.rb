require 'rails_helper'

RSpec.describe Card, type: :model do
  before(:each) do
    @card = Card.new('5', 'Clubs')
  end
  it "has a rank" do
    expect(@card.rank).to eq('5')
  end

  it "has a suit" do
      expect(@card.suit).to eq('Clubs')
  end

  describe '#as_json' do
    it 'can convert a card to a hash' do
      expect(@card.as_json).to eq({'rank'=> '5', 'suit'=> 'Clubs'})
    end
  end

  describe '#from_json' do
    it 'can convert a hash into a card' do
      hash = @card.as_json
      expect(Card.from_json(hash).rank).to eq(@card.rank)
    end
  end
end
