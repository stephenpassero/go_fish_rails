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
        player_turn: 1,
        game_log: game_logic.game_log.get_log,
        winner: false
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
        'player_turn' => 1,
        'player_pairs': [['Player2', 0], ['Player1', 0]],
        'winner': false
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

  context 'running a game' do
    before(:each) do
      @game = GameLogic.new(player_names: ['Player1', 'Player2'], bots: 1)
      @game.start_game
      @player1 = @game.find_player_by_name('Player1')
      @player2 = @game.find_player_by_name('Player2')
      @player1.set_hand([Card.new(rank: '3', suit: 'Diamonds')])
      @player2.set_hand([Card.new(rank: '3', suit: 'Clubs')])
    end

    it 'runs bot turns' do
      @game.run_turn(@player1.name, @player2.name, '2')
      @game.run_turn(@player2.name, @player1.name, '2')
      # Even though only two people played, there should be a least three turns played
      expect(@game.game_log.get_log.length).to be > 2
    end

    it 'requests a card from another player, increments the player turn, and refills cards as need be' do
      @game.run_turn(@player1.name, @player2.name, '3')
      expect(@player1.cards_left).to eq(2)
      expect(@player2.cards_left).to eq(5)
      # Player turn shouldn't have changed because the player got the card he asked for
      expect(@game.player_turn).to eq(1)
    end

    describe '#request_cards' do
      it 'takes a card from a player if that player has the card requested' do
        @game.request_cards(@player1, @player2, '3')
        expect(@player1.cards_left).to eq(2)
        expect(@player2.cards_left).to eq(0)
      end

      it 'goes fishing when the player doesn\'t have the card requested' do
        status = @game.request_cards(@player1, @player2, '8')
        expect(status).to eq('Go Fish')
        expect(@player2.cards_left).to eq(1)
      end
    end

    describe '#refill_cards' do
      it 'gives a player 5 cards when they have no cards' do
        @player1.set_hand([])
        @game.refill_cards([@player1])
        expect(@player1.cards_left).to eq(5)
      end
    end
  end
end
