class GameLogic
  attr_reader(:player_names, :deck, :player_turn, :players)
  def initialize(player_names, deck = Deck.new(), player_turn = 1, players = [])
    @player_names = player_names
    @deck = deck
    @player_turn = player_turn
    @players = players
  end

  def start_game
    @deck.shuffle
    # I'm shuffling the player names so that whoever goes first is random
    @player_names.shuffle!
    @player_names.each do |name|
      @players.push(Player.new(name, @deck.deal(5)))
    end
  end

  def self.from_json(hash)
    GameLogic.new(
      hash['player_names'],
      Deck.from_json(hash['deck']),
      hash['player_turn'],
      hash['players'].map {|player| Player.from_json(player)}
    )
  end

  # Use the as_json and from_json methods here
  def self.load(hash)
   return nil if hash.blank?
   GameLogic.from_json(hash)
 end

 def self.dump(obj)
   obj.as_json
 end

 def as_json(*)
   {
     'player_names' => @player_names,
     'deck' => @deck.as_json,
     'player_turn' => @player_turn,
     'players' => @players.map {|player| player.as_json }
   }
 end
end
