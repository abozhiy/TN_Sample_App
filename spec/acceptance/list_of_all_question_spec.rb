require 'rails_helper'

feature 'List of all questions', %q{
  In order to find question from the list
  As an authenticate user
  I want to be able to find question
} do

  let(:user) { create(:user) }
  let(:questions) { create_list(:question, 5, user: user) }

  scenario 'Authenticate user looks a list of all questions' do
    visit questions_path
    save_and_open_page

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end