require_relative 'acceptance_helper'

feature "Best answer", %q{
  In order other users can find the best answer
  As an author
  I want to be able to choose the best answer
} do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:another_user) { create(:user) }
  let(:another_answer1) { create(:answer, question: question, user: another_user) }
  let(:another_answer2) { create(:answer, question: question, user: another_user) }

  scenario 'Non-authenticated user wants to choose best answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link "Best"
    end
  end

  describe 'Author of question' do

    scenario 'can choose the best answer and only one'

    scenario 'can change the best answer, if it was chosen earlier'
  end
  
  scenario 'The best answer displays first into the list'
end
