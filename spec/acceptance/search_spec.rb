require_relative 'acceptance_helper'

feature 'Search', %q{
  In order to search over content 
  As an User
  I want to be able to search over any content
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:comment) { create(:comment, user: user) }


  scenario 'User can search in questions' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'Question'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end

  scenario 'User can search in answers' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'Answer'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end

  scenario 'User can search in comments' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'Comment'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end

  scenario 'User can search in users' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'User'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end

  scenario 'User can search everywhere' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'All'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end
end
