require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
    visit 'sessions/new'
  end

  it "allow a new user to sign up" do
    expect {
      fill_in 'Name', with: 'Stephen'
      click_on 'Submit'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Game#index'
  end
end
