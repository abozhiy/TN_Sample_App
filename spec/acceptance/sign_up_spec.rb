require_relative 'acceptance_helper'

feature 'Sign up', %q{
  In order to sign up
  As an user
  I want to be able to sign up
  } do

    let(:user) { create(:user) }

    scenario 'Registration with valid attributes' do
      sign_up(user)

      expect(page).to have_content "Welcome! You have signed up successfully."
      expect(current_path).to eq root_path
    end

    scenario 'Registration with invalid attributes' do
      visit new_user_registration_path
      
      fill_in 'Email', with: 'user@test.com'
      fill_in 'Password', with: nil
      fill_in 'Password confirmation', with: nil
      click_on 'Sign up'

      expect(current_path).to eq user_registration_path
    end
  end
