require 'rails_helper'

feature 'Read all answers to question', %q{
  In order get answers to question
  As an user
  I want to be able to read questions and answers
} do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answers) { create_list(:answer, 5, question: question, user: user) }

  scenario 'User read answers to question' do
  
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
