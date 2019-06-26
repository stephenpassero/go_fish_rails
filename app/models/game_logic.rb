class GameLogic
  attr_reader(:player_names, :deck, :player_turn, :players)
  def initialize(player_names:, deck: Deck.new(), player_turn: 1, players: [])
    @player_names = player_names
    @deck = deck
    @player_turn = player_turn
    @players = players
  end

  def start_game
    @deck.shuffle
    @player_names.each do |name|
      @players.push(Player.new(name: name, cards: @deck.deal(5)))
    end
  end

  def find_player_by_name(name)
    players.detect {|player| player.name == name}
  end

  def refill_cards(players)
    players.each do |player|
      if player.cards_left == 0
        player.add_cards(deck.deal(5))
      end
    end
  end

  def increment_player_turn
    @player_turn += 1
    if player_turn > players.length
      @player_turn = 1
    end
  end

  def request_cards(player, target, rank)
    cards = target.cards_in_hand(rank)
    if cards.length > 0
      target.remove_cards_by_rank(rank)
      player.add_cards(cards)
      return true
    end
    'Go Fish'
  end

  def run_turn(player_name, target_name, rank)
    player = find_player_by_name(player_name)
    target = find_player_by_name(target_name)
    if request_cards(player, target, rank) == 'Go Fish'
      player.add_cards(deck.deal(1))
      after_turn(player, target, rank, 'fish')
      increment_player_turn
    end
    after_turn(player, target, rank, 'take')
  end

  def after_turn(player, target, rank, status)
    player.pair_cards
    refill_cards([player, target])
    # Add game log here
  end

  def self.from_json(hash)
    GameLogic.new(
      player_names: hash['player_names'],
      deck: Deck.from_json(hash['deck']),
      player_turn: hash['player_turn'],
      players: hash['players'].map {|player| Player.from_json(player)}
    )
  end

  def player_data(name)
    {
      'player' => find_player_by_name(name).as_json,
      'cards_left' => deck.cards_left,
      'players' => player_names,
      'player_turn' => player_turn,
      'opponents' => players.select {|player| player.name != name}.map(&:as_opponent_json)
    }
  end

  def self.load(hash)
   return nil if hash.blank?
   GameLogic.from_json(hash)
 end

 def self.dump(obj)
   obj.as_json
 end

 def as_json(*)
   {
     'player_names' => player_names,
     'deck' => deck.as_json,
     'player_turn' => player_turn,
     'players' => players.map(&:as_json)
   }
 end
end
