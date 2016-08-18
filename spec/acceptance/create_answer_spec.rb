require 'rails_helper'

feature "Create answer", %q{
  In order to answer the question
  As an authenticate user
  I want to be able to build answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Authenticated user builds answer' do
    sign_in(user)
    visit question_path(question)
    
    # save_and_open_page

    fill_in 'Body', with: 'Answer text'
    click_on 'Post'

    save_and_open_page

    expect(page).to have_content "Your answer successfuly posted."
    expect(current_path).to eq question_path(question)
  end



  scenario 'Authenticated user builds answer with empty body'



  scenario 'Non-authenticated user tries to build answer' do
    visit question_path(question)
    click_on 'Post'
    # save_and_open_page

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end