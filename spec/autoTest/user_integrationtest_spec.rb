require 'rails_helper'

RSpec.describe 'Creating a user and checking if they land in the events page', :type => :feature do
  describe 'successful' do
    it 'has valid inputs and can be routed to events' do # sunny day
      visit new_user_session_path
      fill_in 'email', :with => "temp@admin.com"
      fill_in 'password', :with => "TempPassword"
      click_button "Log in"
      expect(page).to have_content("Signed in successfully.") # Meant to test for false positive with broken create function
    end
  end
end
