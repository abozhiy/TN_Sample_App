require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

let(:user) { create(:user) }
let(:another_user) { create(:user) }
let!(:question) { create(:question, user: another_user) }
let!(:question_comment) { create(:comment, commentable_type: question, user: user) }
let!(:answer) { create(:answer, question: question, user: another_user) }
let!(:answer_comment) { create(:comment, commentable_type: answer, user: user) }


describe "POST #create" do
    sign_in_user


    describe 'Question comment' do

      context "Authenticated user tries to leave comment with valid attributes" do

        it "increase comment count by 1" do
          expect { post :create, id: question_comment, commentable_type: question, comment: attributes_for(:comment), question_id: question.id, format: :js }.to change(question.comments, :count).by(1)
        end
      end

      context "Authenticated user tries to leave comment with invalid attributes" do

        it "doesnt change comment count" do
          expect { post :create, id: question_comment, commentable_type: question, comment: attributes_for(:invalid_comment), question_id: question.id, format: :js }.to_not change(Comment, :count)
        end
      end
    end


    describe 'Answer comment' do

      context "Authenticated user tries to leave comment with valid attributes" do

        it "increase comment count by 1" do
          expect { post :create, id: answer_comment, commentable_type: answer, comment: attributes_for(:comment), answer_id: answer.id, format: :js }.to change(answer.comments, :count).by(1)
        end
      end

      context "Authenticated user tries to leave comment with invalid attributes" do

        it "doesnt change comment count" do
          expect { post :create, id: answer_comment, commentable_type: answer, comment: attributes_for(:invalid_comment), answer_id: answer.id, format: :js }.to_not change(Comment, :count)
        end
      end
    end
  end



  describe "PATCH #update" do
    sign_in_user


    describe 'Question comment' do
      
      it "changes comment attributes" do
        patch :update, id: question_comment, commentable_id: question, comment: { body: "new body" }, format: :js
        expect(question_comment.reload.body).to eq "new body"
      end
    end


    describe 'Answer comment' do
      
      it "changes comment attributes" do
        patch :update, id: answer_comment, commentable_id: answer, comment: { body: "new body" }, format: :js
        expect(answer_comment.reload.body).to eq "new body"
      end
    end
  end



  describe "DELETE #destroy" do
    sign_in_user


    describe 'Question comment' do

      context 'Authenticated user' do
              
        it "can delete own comment" do
          expect { delete :destroy, id: question_comment, format: :js }.to change(Comment, :count).by(-1)
        end
      end

      context 'Authenticated user' do
        let!(:question_comment2) { create(:comment, commentable: question, user: another_user) }

        it 'cannot delete other comment' do
          expect { delete :destroy, id: question_comment2, format: :js }.to_not change(Comment, :count)
        end
      end
    end


    describe 'Answer comment' do

      context 'Authenticated user' do
              
        it "can delete own comment" do
          expect { delete :destroy, id: answer_comment, format: :js }.to change(Comment, :count).by(-1)
        end
      end

      context 'Authenticated user' do
        let!(:answer_comment2) { create(:comment, commentable: answer, user: another_user) }

        it 'cannot delete other comment' do
          expect { delete :destroy, id: answer_comment2, format: :js }.to_not change(Comment, :count)
        end
      end
    end
  end
end