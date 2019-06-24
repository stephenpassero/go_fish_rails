class GameLogic
  attr_reader(:player_names, :deck, :player_turn, :players)
  def initialize(player_names:, deck: Deck.new(), player_turn: 1, players: [])
    @player_names = player_names
    @deck = deck
    @player_turn = player_turn
    @players = players
  end

  # Think about keeping player names or extracting it out
  def start_game
    @deck.shuffle
    # I'm shuffling the player names so that whoever goes first is random
    @player_names.shuffle!
    @player_names.each do |name|
      @players.push(Player.new(name: name, cards: @deck.deal(5)))
    end
  end

  def find_player_by_name(name)
    players.detect {|player| player.name == name}
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
