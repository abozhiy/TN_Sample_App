require_relative 'acceptance_helper'

feature "Best answer", %q{
  In order other users can find the best answer
  As an author
  I want to be able to choose the best answer
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer1) { create(:answer, question: question, user: another_user) }
  let!(:answer2) { create(:answer, question: question, user: another_user) }

  scenario 'Non-authenticated user wants to choose best answer' do
    visit question_path(question)
    within ".answers" do
      expect(page).to_not have_link "Best!"
    end
  end

  describe 'Author of question' do
    before { sign_in(user) }

    scenario 'can choose the best answer and only one', js: true do
      visit question_path(question)
      
      within ".answer-#{answer1.id}" do
        click_on 'Best!'
      end
      
      within ".answer-#{answer1.id} #{'best-answer'}" do
        expect(page).to have_content(answer1.body)
        expect(page).to_not have_content(answer2.body)
      end
    end

    scenario 'can change the best answer, if it was chosen earlier', js: true do
      visit question_path(question)
      answer1.update_attributes(best: true)

      within ".answer-#{answer2.id}" do
        click_on 'Best!'
      end
      
      within ".answer-#{answer2.id} #{'best-answer'}" do
        expect(page).to have_content(answer2.body)
        expect(page).to_not have_content(answer1.body)
      end
    end
  end
  
  scenario 'Other user tries to choose the best answer' do
    sign_in(another_user)

    visit question_path(question)
    within ".answers" do
      expect(page).to_not have_link "Best!"
    end
  end
end
