require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to vote for question
  As an autenticated user
  I want to be able to voit for question
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Not-authenticated user' do
    visit question_path(question)

    within ".question" do
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

    scenario 'can vote for favorite question', js: true do

      within ".question" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
    

    scenario 'can cancel own vote and revote', js: true do

      within ".question" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on 'Cancel'
        expect(page).to have_content 'Rating: 0'
      end
    end

    scenario 'cannot vote for own question', js: true do
      
      click_on 'Ask question'
      fill_in 'Type title...', with: 'Test question'
      fill_in 'Ask your question...', with: 'text text'
      click_on 'Create'

      within ".question" do
        expect(page).to_not have_content '+'
        expect(page).to_not have_content '-'
        expect(page).to have_content 'Rating:'
      end
    end


    scenario 'can vote for question onse', js: true do

      within ".question" do
        expect(page).to have_content 'Rating: 0'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
        click_on '+'
        expect(page).to have_content 'Rating: 1'
      end
    end
  end
end
