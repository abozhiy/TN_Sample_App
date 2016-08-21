require 'rails_helper'

feature 'Update own answer', %q{
  In order to update own answer
  As an authenticated user
  I want to be able update my own answer 
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_question) { create(:question, user: another_user) }
  let(:another_answer) { create(:answer, question: another_question, user: another_user) }

  scenario 'Authenticated user might to update his own answer' do
    sign_in(user)
    visit question_path(question)
    click_on "edit answer"

    expect(page).to have_content "Your answer successfuly updated."
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user wants to update answer' do
    visit question_path(question)

    expect(page).to_not have_link "edit answer"
  end

  scenario 'Authenticated user cannot update answer of another user' do
    sign_in(user)
    visit question_path(another_question)

    expect(page).to_not have_link "edit answer"
  end
end