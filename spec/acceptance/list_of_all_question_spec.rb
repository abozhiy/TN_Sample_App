require 'rails_helper'

feature 'List of all questions', %q{
  In order to find question from the list
  As an user
  I want to be able to find all questions
} do

  let(:user) { create(:user) }
  let!(:questions) { create_list(:question, 5, user: user) }

  scenario 'Authenticate user looks a list of all questions' do
    visit questions_path
  
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
