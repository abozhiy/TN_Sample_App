require 'rails_helper'

feature 'List of all questions', %q{
  In order to find question from the list
  As an authenticate user
  I want to be able to find question
} do

  let(:user) { create(:user) }

  scenario 'Authenticate user looks a list of all questions' do
    sign_in(user)
    visit questions_path
    # save_and_open_page

    expect(page).to have_content("All questions")
  end
  
end