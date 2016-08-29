require_relative 'acceptance_helper'

feature "Create answer", %q{
  In order to answer the question
  As an authenticate user
  I want to be able to build answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Authenticated user builds answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Answer the question...', with: 'Answer text'
    click_on 'Post'

    expect(page).to have_content "Answer text"
    expect(current_path).to eq question_path(question)
  end


  scenario 'Authenticated user tries to create answer with empty body', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Post'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user trying to build answer', js: true do
    visit question_path(question)

    fill_in 'Answer the question...', with: 'Answer text'
    click_on 'Post'

    expect(page).to_not have_content "Answer text"
  end
end
