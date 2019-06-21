require 'rails_helper'

RSpec.describe 'Create Game', type: :system do
  before do
    driven_by(:rack_test)
    visit '/'
    fill_in 'user_name', with: 'Stephen'
    click_on 'Submit'
  end

  it "allows a user to create a new game" do
    click_on 'Create Game'
    expect(page).to have_content "Number of players"
    fill_in 'game_players', with: 4
    click_on 'Create Game'
    expect(page).to have_content "Waiting for 3 more player(s)"
  end

  it "allows a user to leave the lobby of a game" do
    click_on 'Create Game'
    fill_in 'game_players', with: 4
    click_on 'Create Game'
    click_on 'Leave Lobby'
    expect(page).to have_content "Welcome, Stephen"
  end
end
