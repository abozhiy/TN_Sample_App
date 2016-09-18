require_relative 'acceptance_helper'

feature 'Vote for answer', %q{
  In order to vote for answer
  As an autenticated user
  I want to be able to voit for answer
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: another_user) }
  let!(:answer) { create(:answer, question: question, user: another_user) }

  scenario 'Not-authenticated user' do
    visit question_path(question)

    within ".voting-for-answer-#{answer.id}" do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'

      within ".rating-answer-#{answer.id}" do
        expect(page).to have_content 'Rating: 0'
      end
    end
  end

  scenario 'cannot vote for own answer' do

    sign_in(another_user)
    visit question_path(question)

    within ".voting-for-answer-#{answer.id}" do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'

      within ".rating-answer-#{answer.id}" do
        expect(page).to have_content 'Rating: 0'
      end
    end
  end


  describe 'Authenticated user' do

    before do 
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can vote for favorite answer', js: true do
      
      within ".voting-for-answer-#{answer.id}" do

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 0'
        end
        
        click_on '+'
          
        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 1'
        end
      end
    end
    
    scenario 'can cancel own vote and revote', js: true do

      within ".voting-for-answer-#{answer.id}" do

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 0'
        end

        click_on '+'

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 1'
        end

        click_on 'Cancel'

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 0'
        end
      end
    end

    scenario 'can vote for answer onse', js: true do

      within ".voting-for-answer-#{answer.id}" do

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 0'
        end

        click_on '+'

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 1'
        end

        click_on '+'

        within ".rating-answer-#{answer.id}" do
          expect(page).to have_content 'Rating: 1'
        end
      end
    end
  end
end
