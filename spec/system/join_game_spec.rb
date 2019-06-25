require 'rails_helper'
require 'support/system_helper'

RSpec.describe 'Join Game', type: :system do
  before do
    @session1, @session2 = SystemHelper.create_sessions(2)
    SystemHelper.login_users([@session1, @session2])
  end

  it "can have multiple players join the same game" do
    expect(@session1).to have_content "Welcome"
    @session1.click_on 'Create Game'
    @session1.fill_in 'game_players', with: 2
    @session1.click_on 'Create Game'
    expect(@session1).to have_content "Waiting for 1 more player(s)"
    @session2.driver.refresh
    game = Game.all()[0]
    @session2.click_link "Game #1"
    expect(@session2).to_not have_content 'more player(s)'
    @session1.driver.refresh
    expect(@session1).to_not have_content 'more player(s)'
  end
end
