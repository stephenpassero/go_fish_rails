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
    expect(page).to have_content "Number of total players"
    fill_in 'game_players', with: 4
    click_on 'Create Game'
    expect(page).to have_content "Waiting for 3 more player(s)"
  end

  it "allows a user to choose how many bots they want to play with" do
    click_on 'Create Game'
    fill_in 'game_players', with: 3
    fill_in 'game_bots', with: 1
    click_on 'Create Game'
    expect(page).to have_content "All bots have joined. Waiting for 1 more human player(s)"
  end

  it "allows a user to leave the lobby of a game" do
    click_on 'Create Game'
    fill_in 'game_players', with: 4
    click_on 'Create Game'
    click_on 'Leave Lobby'
    expect(page).to have_content "Welcome, Stephen"
  end
end
