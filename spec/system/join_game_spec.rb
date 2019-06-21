require 'rails_helper'

RSpec.describe 'Join Game', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    visit '/'
  end

  # it "players can join an actual game" do
  #   game = Game.create(players: 2)
  #   user1 = User.create(name: 'Player1', game_id: game.id)
  #   user2 = User.create(name: 'Stephen')
  #   fill_in 'user_name', with: 'Stephen'
  #   click_on 'Submit'
  #   visit games_join_path(game)
  #   expect(page).to have_content('Actual React Component')
  # end
end
