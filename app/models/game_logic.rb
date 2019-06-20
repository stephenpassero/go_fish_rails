require 'json'

class GameLogic
  attr_reader(:player_names, :deck, :player_turn, :players)
  def initialize(player_names)
    # I'm shuffling the player names so that whoever goes first is random
    @player_names = player_names.shuffle!
    @deck = Deck.new()
    @deck.shuffle
    @player_turn = 1
    @players = {}
  end

  def start_game
    @player_names.each do |name|
      @players[name] = Player.new(name)
    end
    @players.values.each {|player| player.add_cards(@deck.deal(5))}
  end

  def self.load(hash)
   return nil if hash.blank?
   hash.to_json
 end

 def self.dump(obj)
   obj.as_json
 end
end
