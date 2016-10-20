require_relative 'acceptance_helper'

feature "Subscribe to question", %q{
  In order to get the changes of question
  As authenticated user
  I want to be able to get info about new answer of question
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }


  scenario 'Not-authenticated user' do
    visit question_path(question)

    expect(page).to_not have_link 'Subscribe'
    expect(page).to_not have_link 'Unscribe'
  end


  describe 'Author of question' do
    before do 
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Can unscribe from own question', js: true do
      click_on 'Unscribe'

      within '.subscription' do
        expect(page).to have_link 'Subscribe'
        expect(page).to_not have_link 'Unscribe'
      end
    end
  end


  describe 'Authenticated user' do

    before do 
      sign_in(another_user)
      visit question_path(question)
    end

    scenario 'Can subscribe to the question', js: true do
      click_on 'Subscribe'

      within '.subscription' do
        expect(page).to have_link 'Unscribe'
        expect(page).to_not have_link 'Subscribe'
      end
    end

    scenario 'Can unscribe from the question', js: true do
      click_on 'Subscribe'

      within '.subscription' do
        click_on 'Unscribe'
        expect(page).to have_link 'Subscribe'
        expect(page).to_not have_link 'Unscribe'
      end
    end
  end
end
