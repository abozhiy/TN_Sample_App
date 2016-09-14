require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:question_attachment) { create(:attachment, attachable: question) }
  let!(:answer_attachment) { create(:attachment, attachable: answer) }

  describe 'DELETE #destroy' do

    describe 'Question attachment' do
      
      context 'Author of question' do
        sign_in_user
      
        it "deletes attachment" do
          expect { delete :destroy, id: question_attachment, format: :js }.to change(Attachment, :count).by(-1)
        end

        it "render destroy template" do
          delete :destroy, id: question_attachment, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'Other user' do

        it 'cannot delete attachment' do
          expect { delete :destroy, id: question_attachment, format: :js }.to_not change(Attachment, :count)
        end
      end
    end

    describe 'Answer attachment' do
      
      context 'Author of answer' do
        sign_in_user

        it "deletes attachment" do
          expect { delete :destroy, id: answer_attachment, format: :js }.to change(Attachment, :count).by(-1)
        end

        it "render destroy template" do
          delete :destroy, id: answer_attachment, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'Other user' do

        it 'cannot delete attachment' do
          expect { delete :destroy, id: answer_attachment, format: :js }.to_not change(Attachment, :count)
        end
      end
    end
  end
end
