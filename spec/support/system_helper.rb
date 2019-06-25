class SystemHelper
  def self.create_sessions(num_of_players)
    sessions = []
    num_of_players.times do
      sessions.push(Capybara::Session.new(:selenium_chrome_headless, Rails.application))
    end
    sessions
  end

  def self.login_users(sessions)
    sessions.each_with_index do |session, index|
      session.visit '/'
      session.fill_in 'user_name', with: "Player#{index + 1}"
      session.click_on 'Submit'
    end
  end
end
