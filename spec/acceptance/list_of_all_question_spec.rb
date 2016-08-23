require 'rails_helper'

feature 'List of all questions', %q{
  In order to find question from the list
  As an authenticate user
  I want to be able to find all questions
} do

  let(:user) { create(:user) }
  let!(:questions) { create_list(:question, 5, user: user) }

  scenario 'Authenticate user looks a list of all questions' do
    sign_in(user)
    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end
end
