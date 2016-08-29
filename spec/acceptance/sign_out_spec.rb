require_relative 'acceptance_helper'

feature 'Sign out', %q{
  In order to sign out
  As an user
  I want to able sign out
} do

  let(:user) { create(:user) }

  scenario 'Authenticated user sign out' do
    sign_in(user)
    visit questions_path
    click_on 'Sign out'

    expect(page).to have_content "Signed out successfully."
    expect(current_path).to eq root_path
  end
end
