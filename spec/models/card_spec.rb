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
end
