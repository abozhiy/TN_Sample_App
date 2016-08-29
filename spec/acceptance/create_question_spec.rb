require_relative 'acceptance_helper'

feature "Create question", %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
} do

  let(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    click_on 'Ask question'
    fill_in 'Type title...', with: 'Test question'
    fill_in 'Ask your question...', with: 'text text'
    click_on 'Done'
    
    expect(page).to have_content "Your question successfuly created."
    expect(page).to have_content "Test question"
    expect(page).to have_content "text text"
    expect(current_path).to eq question_path(Question.last)
  end

  scenario 'Non-authenticated user ties create question' do
    visit questions_path

    expect(page).to_not have_link "Ask question"
  end
end
