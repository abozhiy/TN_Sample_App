require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }


  describe "POST #create" do
    sign_in_user

    context "Authenticated user creates answer with valid attributes" do

      it "saves a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end

      it 'associates with current user' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(user.answers, :count).by(1)
      end

      it "render create template" do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context "Authenticated user tries to create answer with invalid attributes" do

      it "doesn't save a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js 
        expect(response).to render_template :create
      end
    end
  end

  describe "PATCH #update" do
    sign_in_user

    it "assigns the requested answer to @answer" do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it "changes answer attributes" do
      patch :update, id: answer, question_id: question, answer: { body: "new body" }, format: :js
      answer.reload
      expect(answer.body).to eq "new body"
    end

    it "redirect to question" do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to redirect_to question
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'Delete own answer' do
      
      it "deletes answer" do
        expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it "renders destroy template" do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'Delete other answer' do
      let!(:another_user) { create(:user) }
      let!(:another_question) { create(:question, user: another_user) }
      let!(:another_answer) { create(:answer, question: another_question, user: another_user) }

      it 'cannot delete other answer' do
        expect { delete :destroy, id: another_answer, format: :js }.to_not change(Answer, :count)
      end

      it 'renders destroy template' do
        delete :destroy, id: another_answer, format: :js
        expect(response).to render_template :destroy
      end
    end
  end
end
