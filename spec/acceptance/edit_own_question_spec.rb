require_relative 'acceptance_helper'

feature 'Edit own question', %q{
  In order to edit own question
  As an author
  I want to be able to edit my own question
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_question) { create(:question, user: another_user) }

  scenario 'Non-authenticated user tries to edit question' do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'sees link "Edit"' do
      visit question_path(question)

      expect(page).to have_link "Edit"
    end

    scenario 'tries to edit his question', js: true do
      visit question_path(question)
      click_on "Edit"
      fill_in "Title", with: 'Test question'
      fill_in "Body", with: 'text text'
      click_on 'Edit'

      expect(page).to have_content "Your question successfuly updated."
      expect(page).to have_content "Test question"
      expect(page).to have_content "text text"
      expect(current_path).to eq question_path(question)
    end

    scenario 'tries to edit question of another user' do
      visit question_path(another_question)

      expect(page).to_not have_link "Edit"
    end
  end
end
