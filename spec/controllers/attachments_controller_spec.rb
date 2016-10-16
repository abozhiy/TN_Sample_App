require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  describe 'DELETE #destroy' do

    describe 'Question attachment' do
      
      let!(:object_attachment) { create(:attachment, attachable: question) }
      it_behaves_like 'Delete attachment'
    end

    describe 'Answer attachment' do
      
      let!(:object_attachment) { create(:attachment, attachable: answer) }
      it_behaves_like 'Delete attachment'
    end
  end
end
