require_relative 'acceptance_helper'

feature 'Comment question', %q{
  In order to commenting question
  As an autenticated user
  I want to be able to commenting question
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  

  describe 'Not-autenticated user' do
    
    before do
      visit question_path(question)
    end

    let!(:comment) { create(:comment, commentable_type: question, user: user) }
    
    scenario 'cannot leave a comment' do

      within '.question' do

        expect(page).to_not have_link 'Leave comment'

        within '.comment-question-#{question.id}' do
          expect(page).to have_content comment.body
        end
      end
    end
  end


  describe 'Authenticated user' do

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'tries to leave a comment' do

      within '.question' do
        click_on 'Leave comment'
        fill_in 'Leave your comment...', with: 'Comment text'
        click_on 'Comment'

        within '.comment-question-#{question.id}' do
          expect(page).to have_content 'Comment text'
          expect(current_path).to eq question_path(question)
        end
      end
    end
    

    scenario 'tries to leave a comment with empty body' do
      
      within '.question' do
        click_on 'Leave comment'
        click_on 'Comment'

        expect(page).to have_content "Body can't be blank"
      end
    end
  end
end
