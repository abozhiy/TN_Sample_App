require_relative 'acceptance_helper'

feature "Create answer", %q{
  In order to answer the question
  As an authenticate user
  I want to be able to build answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Non-authenticated user trying to build answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content "Answer the question..."
  end

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'tries to create answer', js: true do
      visit question_path(question)

      fill_in 'Answer the question...', with: 'Answer text'
      click_on 'Post'

      expect(page).to have_content "Answer text"
      expect(current_path).to eq question_path(question)
    end

    scenario 'tries to create answer with empty body', js: true do
      visit question_path(question)
      click_on 'Post'

      expect(page).to have_content "Body can't be blank"
    end
  end
end
