require 'rails_helper'

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

  scenario 'Authenticated user might to delete his own answer' do
    sign_in(user)
    visit question_path(question)
    # save_and_open_page
    click_on "delete"
    

    expect(page).to have_content "Your answer successfuly deleted."
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user wants to delete answer' do
    visit question_path(question)

    within('.answers') do
      expect(page).to_not have_link "delete"
    end
  end

  scenario 'Authenticated user cannot delete answer of another user' do
    sign_in(user)
    visit question_path(another_question)

    within('.answers') do
      expect(page).to_not have_link "delete"
    end
  end
end