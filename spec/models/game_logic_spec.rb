require 'rails_helper'

RSpec.describe GameLogic, type: :model do
  before(:each) do
    @game = GameLogic.new(['Stephen', 'Player2', 'Malachi', 'Josh'])
  end

  describe '#start_game' do
    it 'creates new players and deals five cards to each of them' do
      @game.start_game
      # 52 cards to start with, but then 5 cards were dealt to 4 different players
      expect(@game.deck.cards_left).to eq(52 - 20)
      expect(@game.players).not_to eq(nil)
    end
  end
end
