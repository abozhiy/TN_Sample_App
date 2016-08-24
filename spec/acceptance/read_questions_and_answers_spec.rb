require 'rails_helper'

feature 'Read all answers to question', %q{
  In order get answers to question
  As an user
  I want to be able to read questions and answers
} do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answers) { 5.times { create(:answer, question: question, user: user) } }

  scenario 'User read answers to question' do
  
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    
    expect(page).to have_selector('h4', text: answers)
  end
end
