require 'rails_helper'

RSpec.describe GameLogic, type: :model do
  before(:each) do
    @game = GameLogic.new(player_names: ['Stephen', 'Player2', 'Player3', 'Player4'])
  end

  describe '#as_json' do
    it 'converts an object to a hash' do
      game_logic = GameLogic.new(player_names: ['Player1', 'Player2'])
      game_logic.deck.set_deck([Card.new(rank: '8', suit: 'Hearts'), Card.new(rank: '2', suit: 'Spades')])
      player = Player.new(name: 'Player1', cards: [Card.new(rank: '3', suit: 'Diamonds')])
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
      game_logic = GameLogic.new(player_names: ['Player1', 'Player2'])
      game_logic.deck.set_deck([Card.new(rank: '8', suit: 'Hearts'), Card.new(rank: '2', suit: 'Spades')])
      player = Player.new(name: 'Player1', cards: [Card.new(rank: '3', suit: 'Diamonds')])
      game_logic.players.push(player)
      new_game_logic = GameLogic.from_json(game_logic.as_json)
      expect(new_game_logic.players[0].name).to eq(game_logic.players[0].name)
      expect(new_game_logic.deck.cards[0].rank).to eq(game_logic.deck.cards[0].rank)
    end
  end

  describe '#player_data' do
    it 'converts an object of the game into a hash of necessary data for a single player' do
      game_logic = GameLogic.new(player_names: ['Player1', 'Player2'])
      game_logic.deck.set_deck([Card.new(rank: '8', suit: 'Hearts'), Card.new(rank: '2', suit: 'Spades')])
      player1 = Player.new(name: 'Player1', cards: [Card.new(rank: '3', suit: 'Diamonds')])
      player2 = Player.new(name: 'Player2', cards: [Card.new(rank: '5', suit: 'Diamonds')])
      game_logic.players.push(player1)
      game_logic.players.push(player2)
      expect(game_logic.player_data('Player1')).to include_json(
        'cards_left' => 2,
        'player' => player1.as_json,
        'opponents' => [{'name' => 'Player2', 'cards_left' => 1, 'pairs' => []}],
        'player_turn' => 1
      )
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
