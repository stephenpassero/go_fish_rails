require 'rails_helper'

RSpec.describe GameLogic, type: :model do
  before(:each) do
    @game = GameLogic.new(['Stephen', 'Player2', 'Player3', 'Player4'])
  end

  describe '#as_json' do
    it 'converts an object to a hash' do
      game_logic = GameLogic.new(['Player1', 'Player2'])
      game_logic.deck.set_deck([Card.new('8', 'Hearts'), Card.new('2', 'Spades')])
      player = Player.new('Player1', [Card.new('3', 'Diamonds')])
      game_logic.players.push(player)
      expect(game_logic.as_json).to include_json(
        deck: {cards: [{rank: '8', suit: 'Hearts'}, {rank: '2', suit: 'Spades'}]},
        player_names: ['Player1', 'Player2'],
        players: [player.as_json],
        player_turn: 1
      )
    end
  end

  describe '#from_json' do
    it 'converts an object to a hash' do
      game_logic = GameLogic.new(['Player1', 'Player2'])
      game_logic.deck.set_deck([Card.new('8', 'Hearts'), Card.new('2', 'Spades')])
      player = Player.new('Player1', [Card.new('3', 'Diamonds')])
      game_logic.players.push(player)
      new_game_logic = GameLogic.from_json(game_logic.as_json)
      expect(new_game_logic.players[0].name).to eq(game_logic.players[0].name)
      expect(new_game_logic.deck.cards[0].rank).to eq(game_logic.deck.cards[0].rank)
    end
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
