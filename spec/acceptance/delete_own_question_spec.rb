require_relative 'acceptance_helper'

feature 'Delete own question', %q{
  In order to delete own question or answer
  As an authenticated user
  I want to be able delete my own question/answer 
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_question) { create(:question, user: another_user) }

  scenario 'Authenticated user might to delete his own question' do
    sign_in(user)
    visit question_path(question)
    click_on "Delete"

    expect(page).to have_content "Your question successfuly deleted."
    expect(current_path).to eq questions_path
    expect(page).to_not have_content(question.title)
  end

  scenario 'Non-authenticated user wants to delete question' do
    visit question_path(question)

    expect(page).to_not have_link "Delete"
  end

  scenario 'Authenticated user cannot delete question of another user' do
    sign_in(user)
    visit question_path(another_question)

    expect(page).to_not have_link "Delete"
  end
end
