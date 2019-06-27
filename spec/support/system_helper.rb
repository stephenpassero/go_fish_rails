class SystemHelper
  def self.create_sessions(num_of_players)
    num_of_players.times.map {Capybara::Session.new(:selenium_chrome_headless, Rails.application)}
  end

  def self.login_users(sessions)
    sessions.each_with_index do |session, index|
      session.visit '/'
      session.fill_in 'user_name', with: "Player#{index + 1}"
      session.click_on 'Submit'
    end
  end

  def self.game_logic
    player1 = Player.new(name: 'Player1', cards: [Card.new(rank: 'A', suit: 'Spades'), Card.new(rank: 'A', suit: 'Hearts'), Card.new(rank: 'A', suit: 'Diamonds')], pairs: [])
    player2 = Player.new(name: 'Player2', cards: [Card.new(rank: 'A', suit: 'Clubs')], pairs: [])

    players = [player1, player2]
    game = GameLogic.new(player_names: ['Player1', 'Player2'], deck: {cards: []}, player_turn: 1, players: players, game_log: GameLog.new())
  end
end
