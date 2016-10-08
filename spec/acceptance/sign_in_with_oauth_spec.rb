require_relative 'acceptance_helper'


feature 'Sign in with omniauth', %q{
  In order to can signin faster
  As an user
  I want to be able to signin with facebook & other sotial network
} do


  describe "OmniAuthorization from Sign_in page" do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = nil
      OmniAuth.config.mock_auth[:twitter] = nil
    end


    context 'Sign in with Facebook' do

      scenario "User can sign in with facebook account" do
        visit new_user_session_path
        mock_auth_hash('facebook')
        click_link "Sign in with Facebook"
        expect(page).to have_content("Successfully authenticated from facebook account.")
        expect(page).to have_link("Sign out!")
      end

      scenario "It can handle authentication error" do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit new_user_session_path
        expect(page).to have_link("Sign in with Facebook")
        click_link "Sign in with Facebook"
        expect(page).to have_content("Could not authenticate you from Facebook because")
      end
    end


    context 'Sign in with Twitter' do

      scenario "User can sign in user with twitter account" do
        visit new_user_session_path
        expect(page).to have_link("Sign in with Twitter")
        mock_auth_hash('twitter')
        click_link "Sign in with Twitter"
        expect(page).to have_content("Successfully authenticated from twitter account.")
        expect(page).to have_link("Sign out!")
      end

      scenario "It can handle authentication error" do
        OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
        visit new_user_session_path
        expect(page).to have_link("Sign in with Twitter")
        click_link "Sign in with Twitter"
        expect(page).to have_content("Could not authenticate you from Twitter because")
      end
    end
  end


  describe "OmniAuthorization from Sign_up page" do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = nil
      OmniAuth.config.mock_auth[:twitter] = nil
    end


    context 'Sign in with Facebook' do

      scenario "User can sign in with facebook account" do
        visit new_user_registration_path
        expect(page).to have_link("Sign in with Facebook")
        mock_auth_hash('facebook')
        click_link "Sign in with Facebook"
        expect(page).to have_content("Successfully authenticated from facebook account.")
        expect(page).to have_link("Sign out!")
      end

      scenario "It can handle authentication error" do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
        visit new_user_registration_path
        expect(page).to have_link("Sign in with Facebook")
        click_link "Sign in with Facebook"
        expect(page).to have_content("Could not authenticate you from Facebook because")
      end
    end


    context 'Sign in with Twitter' do

      scenario "User can sign in user with twitter account" do
        visit new_user_registration_path
        expect(page).to have_link("Sign in with Twitter")
        mock_auth_hash('twitter')
        click_link "Sign in with Twitter"
        expect(page).to have_content("Successfully authenticated from twitter account.")
        expect(page).to have_link("Sign out!")
      end

      scenario "It can handle authentication error" do
        OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
        visit new_user_registration_path
        expect(page).to have_link("Sign in with Twitter")
        click_link "Sign in with Twitter"
        expect(page).to have_content("Could not authenticate you from Twitter because")
      end
    end
  end
end
