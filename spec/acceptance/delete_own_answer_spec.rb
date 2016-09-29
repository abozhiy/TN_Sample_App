require_relative 'acceptance_helper'

feature 'Delete own answer', %q{
  In order to delete own answer
  As an authenticated user
  I want to be able delete my own answer 
} do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_question) { create(:question, user: another_user) }
  let(:another_answer) { create(:answer, question: another_question, user: another_user) }

  scenario 'Non-authenticated user tries to delete answer' do
    visit question_path(question)

    within('.answers') do
      expect(page).to_not have_link "delete"
    end
  end

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'tries to delete his answer', js: true do
    
      visit question_path(question)
      within '.answers' do
        click_link "Delete"
      end

      expect(page).to have_content "Answer was successfully destroyed."
      expect(current_path).to eq question_path(question)
      expect(page).to_not have_content(answer.body)
    end
  
    scenario 'tries to delete answer of another user' do
      visit question_path(another_question)

      within('.answers') do
        expect(page).to_not have_link "delete"
      end
    end
  end
end
