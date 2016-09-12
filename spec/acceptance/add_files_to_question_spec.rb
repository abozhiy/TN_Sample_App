require_relative 'acceptance_helper'

feature "Add files to question", %q{
  In order to illustrate the question
  As author of question
  I want to be able to attach files
} do

  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User can add file when create question' do
    fill_in 'Type title...', with: 'Test question'
    fill_in 'Ask your question...', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    
    within '.question-attachments' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

  scenario 'User can add a few files when create question' do
    fill_in 'Type title...', with: 'Test question'
    fill_in 'Ask your question...', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Add file'

    within '.attachment_fields' do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Create'
    
    within '.question-attachments' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end
end
