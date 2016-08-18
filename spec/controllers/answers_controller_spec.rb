require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { build(:answer, question: question) }


  describe "POST #create" do
    sign_in_user

    context "create with valid attributes" do

      it "saves a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it "redirects to question path" do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "create with invalid attributes" do

      it "doesn't save a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end
end