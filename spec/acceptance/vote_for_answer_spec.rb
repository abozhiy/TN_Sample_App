require_relative 'acceptance_helper'

feature 'Vote for answer', %q{
  In order to vote for answer
  As an autenticated user
  I want to be able to voit for answer
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: another_user) }

  scenario 'Not-authenticated user' do
    visit question_path(question)

    within ".answer-#{answer.id}" do
      expect(page).to_not have_content '+'
      expect(page).to_not have_content '-'
      expect(page).to have_content 'Rating:'
    end
  end

  describe 'Authenticated user' do

    before do 
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can vote for favorite answer', js: true do

      within ".answer-#{answer.id}" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
    

    scenario 'can cancel own vote and revote', js: true do

      within ".answer-#{answer.id}" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on 'Cancel'
        expect(page).to have_content 'Rating: 0'
      end
    end

    scenario 'cannot vote for own answer', js: true do

      fill_in 'Answer the question...', with: 'Answer text'
      click_on 'Post'

      within ".answer-#{answer.id}" do
        expect(page).to_not have_content '+'
        expect(page).to_not have_content '-'
        expect(page).to have_content 'Rating:'
      end
    end


    scenario 'can vote for answer onse', js: true do

      within ".answer-#{answer.id}" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
  end
end
