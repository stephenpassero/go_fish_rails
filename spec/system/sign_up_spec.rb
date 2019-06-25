require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
    visit '/'
  end

  it "allows a new user to sign up" do
    fill_in 'user_name', with: 'Stephen'
    click_on 'Submit'
    expect(page).to have_content 'Welcome, Stephen'
  end
end
