require 'rails_helper'
require 'support/system_helper'

RSpec.describe 'Run Turn', type: :system do
  before do
    @session1, @session2 = SystemHelper.create_sessions(2)
    SystemHelper.login_users([@session1, @session2])
    create_and_join_game
  end

  it 'can click on cards and select them' do
    @session1.driver.refresh
    card = @session1.all('.card').last
    card.click
    selected_card = @session1.all('.selected').last
    expect(selected_card).to eq(card)
  end

  it 'can\'t select cards when it\'s not the the player\'s turn' do
    card2 = @session2.all('.card').last
    card2.click
    expect(card2.has_css?('.selected')).to eq(false)
  end

  it 'can take cards from other players' do
    @session1.driver.refresh
    run_turn(@session1)
    @session1.driver.refresh
    expect(@session1.all('.card').length).to be > 5
    expect(@session1.all('.logStatement').length).to be > 0
  end

  it 'has bots' do
    @session1.driver.refresh
    expect(@session1.all('.opponent').length).to eq 2
  end

  private

  def run_turn(session)
    session.driver.refresh
    card = session.all('.card').last
    card.click
    opponent = session.all('.opponent').first
    opponent.click
    request_button = session.all('.requestCards').first
    request_button.click
  end

  def create_and_join_game
    @session1.click_on 'Create Game'
    @session1.fill_in 'game_players', with: 3
    @session1.fill_in 'game_bots', with: 1
    @session1.click_on 'Create Game'
    @session2.driver.refresh
    @session2.click_link "Game #1"
  end
end
