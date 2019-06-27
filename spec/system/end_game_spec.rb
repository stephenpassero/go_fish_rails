require 'rails_helper'
require 'support/system_helper'

RSpec.describe 'End Game', type: :system do
  it "renders the end game view when the game is over" do
    user1 = User.create(name: 'Player1')
    user2 = User.create(name: 'Player2')
    game = Game.create(players: 2, game_logic: SystemHelper.game_logic, start_at: Time.now())
    GameUser.create(user_id: user1.id, game_id: game.id)
    GameUser.create(user_id: user2.id, game_id: game.id)
    session1 = Capybara::Session.new(:selenium_chrome, Rails.application)
    session2 = Capybara::Session.new(:selenium_chrome, Rails.application)
    SystemHelper.login_users([session1, session2])
    session1.visit("/games/#{game.id}")
    session2.visit("/games/#{game.id}")
    session1.driver.refresh
    card = session1.all('.card').last
    card.click
    opponent = session1.all('.opponent').first
    opponent.click
    request_button = session1.all('.requestCards').first
    request_button.click
    session1.driver.refresh
    # If I take out page here, the test doesn't fail miserably
    expect(page).to have_content('Game Over')
  end
end
