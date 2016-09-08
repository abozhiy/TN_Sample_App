require_relative 'acceptance_helper'

feature "Add files to answer", %q{
  In order to illustrate the answer
  As author of answer
  I want to be able to attach files
} do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when create answer' do
    fill_in 'Answer the question...', with: 'Answer text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Post'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
