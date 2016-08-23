require 'rails_helper'

feature 'Edit only own question', %q{
  In order to edit own question
  As an authenticated user
  I want to be able to edit my own question
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_question) { create(:question, user: another_user) }

  scenario 'Authenticated user might to edit his own question' do
    sign_in(user)
    visit question_path(question)
    click_on "Edit"
    fill_in 'Type title...', with: 'Test question'
    fill_in 'Type new question...', with: 'text text'
    click_on 'Create'

    expect(page).to have_content "Your question successfuly updated."
    expect(page).to have_content "Test question"
    expect(page).to have_content "text text"
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user wants to edit question' do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end

  scenario 'Authenticated user cannot edit question of another user' do
    sign_in(user)
    visit question_path(another_question)

    expect(page).to_not have_link "Edit"
  end
end
