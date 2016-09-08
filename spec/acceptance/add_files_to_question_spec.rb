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

  scenario 'User adds file when create question' do
    fill_in 'Type title...', with: 'Test question'
    fill_in 'Ask your question...', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb'
  end
end