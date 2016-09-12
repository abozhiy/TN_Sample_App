require_relative 'acceptance_helper'

feature "Remove files from answer", %q{
  In order to delete the answer attachments
  As author of answer
  I want to be able to delete files
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question:question, user: user) }
  let!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'Author deletes attachment from his answer', js: true do
    sign_in(user)
    visit question_path(question)
  
    within '.answer-attachments' do
      click_on 'Remove file'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end

  scenario 'Other user tries to delete attachment from answer' do
    sign_in(another_user)
    visit question_path(question)

    within '.answer-attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link "Remove file"
    end
  end
end
