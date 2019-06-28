class GameLogic
  attr_reader(:player_names, :deck, :player_turn, :players, :game_log, :bots)
  def initialize(player_names:, deck: Deck.new(), player_turn: 1, players: [], game_log: GameLog.new(), bots: 0)
    @player_names = player_names
    @deck = deck
    @player_turn = player_turn
    @players = players
    @game_log = game_log
    @bots = bots
  end

  def start_game
    @deck.shuffle
    @player_names.each do |name|
      @players.push(Player.new(name: name, cards: @deck.deal(5)))
    end
    index = 1
    bots.times do
      @players.push(Player.new(name: "Bot#{index}", cards: @deck.deal(5), bot: true))
      index += 1
    end
  end

  def player_pairs
    player_pairs = []
    players.each do |player|
      player_pairs.push([player.name, player.pairs.length])
    end
    player_pairs.sort_by{|arr| arr[1]}.reverse
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

  def winner?
    cards_left = false
    players.each do |player|
      if player.cards_left > 0
        cards_left = true
      end
    end
    return !cards_left
  end

  def increment_player_turn
    @player_turn += 1
    if player_turn > players.length
      @player_turn = 1
    end
    while players[player_turn - 1].cards_left == 0 && winner? == false
      @player_turn += 1
    end
  end

  def cards_in_play?
    cards_in_play = false
    players.each do |player|
      if player.cards_left > 0
        cards_in_play = true
      end
    end
    cards_in_play
  end

  def pair_cards(player)
    paired_rank = player.pair_cards
    if paired_rank
      game_log.add_log('pair', player, nil, paired_rank)
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
    else
      after_turn(player, target, rank, 'take')
    end
  end

  def after_turn(player, target, rank, status)
    game_log.add_log(status, player, target, rank)
    pair_cards(player)
    refill_cards([player, target])
    increment_player_turn if player.cards_left == 0
    run_bot_turns
  end

  def run_bot_turns
    binding.pry
    if players[player_turn].bot && winner? == false
      binding.pry
      increment_player_turn
    end
  end

  def self.from_json(hash)
    GameLogic.new(
      player_names: hash['player_names'],
      deck: Deck.from_json(hash['deck']),
      player_turn: hash['player_turn'],
      players: hash['players'].map {|player| Player.from_json(player)},
      game_log: GameLog.new(hash['game_log'])
    )
  end

  def player_data(name)
    {
      'player' => find_player_by_name(name).as_json,
      'cards_left' => deck.cards_left,
      'players' => player_names,
      'player_turn' => player_turn,
      'opponents' => players.select {|player| player.name != name}.map(&:as_opponent_json),
      'game_log' => game_log.get_log,
      'player_pairs' => player_pairs,
      'winner' => winner?
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
     'players' => players.map(&:as_json),
     'game_log' => game_log.get_log,
     'winner' => winner?
   }
 end
end
