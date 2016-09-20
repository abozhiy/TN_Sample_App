require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to vote for question
  As an autenticated user
  I want to be able to voit for question
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: another_user) }

  scenario 'Not-authenticated user' do
    visit question_path(question)

    within ".voting-for-question-#{question.id}" do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'

      within ".rating-question-#{question.id}" do
        expect(page).to have_content 'Rating: 0'
      end
    end
  end

  scenario 'cannot vote for own question' do
    sign_in(another_user)
    visit question_path(question)

    within ".voting-for-question-#{question.id}" do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'

      within ".rating-question-#{question.id}" do
        expect(page).to have_content 'Rating: 0'
      end
    end
  end


  describe 'Authenticated user' do

    before do 
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can vote for favorite question', js: true do

      within ".voting-for-question-#{question.id}" do

        within ".rating-question-#{question.id}" do
          expect(page).to have_content 'Rating: 0'
        end

        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
    

    scenario 'can cancel own vote and revote', js: true do

      within ".voting-for-question-#{question.id}" do

        within ".rating-question-#{question.id}" do
          expect(page).to have_content 'Rating: 0'
        end

        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on 'Cancel'
        expect(page).to have_content 'Rating: 0'
      end
    end

    scenario 'can vote for question onse', js: true do

      within ".voting-for-question-#{question.id}" do

        within ".rating-question-#{question.id}" do
          expect(page).to have_content 'Rating: 0'
        end

        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
  end
end
