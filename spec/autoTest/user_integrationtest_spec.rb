require 'rails_helper'

# rubocop:disable RSpec/MultipleDescribes
RSpec.describe 'Verify users can login', :type => :feature do
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

RSpec.describe 'Verify users can signup', :type => :feature do
  describe 'successful' do
    it 'has valid inputs' do
      visit new_user_session_path
      fill_in 'email', :with => "test_signup@admin.com"
      fill_in 'password', :with => "123456"
      fill_in 'password_confirmation', :with => "123456"
      fill_in 'first_name', :with => "John"
      fill_in 'last_name', :with => "Doe"
      fill_in 'uin', :with => "999009999"
      click_button "Sign up"
      expect(page).to have_content("Welcome! You have signed up successfully.") # Meant to test for bad signup
    end
  end
end
# rubocop:enable RSpec/MultipleDescribes
