require 'rails_helper'

feature 'List of all questions', %q{
  In order to find question from the list
  As an user
  I want to be able to find all questions
} do

  let(:user) { create(:user) }
  let!(:questions) { 5.times { create(:question, user: user) } }

  scenario 'Authenticate user looks a list of all questions' do
    visit questions_path
  
    expect(page).to have_selector('h4', text: questions)
  end
end
