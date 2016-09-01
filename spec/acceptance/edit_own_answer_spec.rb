require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I want to be able edit my own answer 
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:another_user) { create(:user) }
  let!(:another_question) { create(:question, user: another_user) }
  let!(:another_answer) { create(:answer, question: another_question, user: another_user) }
  

  scenario 'Non-authenticated user wants to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
    end

    scenario 'can see link to edit' do
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link "Edit"
      end
    end

    scenario 'try to edit his answer', js: true do
      visit question_path(question)
      within '.answers' do
        click_link 'Edit'
        fill_in 'Edit your answer:', with: 'edited answer'
        click_on 'Done'

        expect(page).to_not have_content answer.body
        expect(page).to have_content "edited answer"
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit answer of another user' do
      visit question_path(another_question)

      expect(page).to_not have_link "Edit"
    end
  end
end
