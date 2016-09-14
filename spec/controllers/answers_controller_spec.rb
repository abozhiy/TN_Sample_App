require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }


  describe 'PATCH #vote' do    

    context 'Not-authenticated user' do

      it 'cannot vote for answer' do
        expect { patch :vote_up, id: answer, question_id: question, format: :js }.to_not change(answer.votes, :count)
      end
    end

    context "Authenticated user" do
      sign_in_user

      it 'cannot vote for own answer' do
        expect { patch :vote_up, id: answer, question_id: question, user: user, format: :js }.to_not change(answer.votes, :count)
      end

      it 'can increase answer votes count by 1' do
        expect { patch :vote_up, id: answer, question_id: question, format: :js }.to change(answer.votes, :count).by(1)
      end

      it 'can decrease answer votes count by 1' do
        expect { patch :vote_down, id: answer, question_id: question, format: :js }.to change(answer.votes, :count).by(-1)
      end
    end
  end

  describe 'DELETE #vote' do
    sign_in_user

    it 'can cancel own answer vote' do
      expect { delete :vote_cancel, id: answer, question_id: question, format: :js }.to change(Vote, :count).by(-1)
    end
  end


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

  describe "PATCH #best" do
    
    let(:another_user) { create(:user) }
    let!(:answer2) { create(:answer, question: question, user: another_user) }
    
    
    context "Author of question" do
      sign_in_user

      it 'assigns the requested answer_id to @answer' do
        patch :best, id: answer, question_id: question, format: :js
        answer.reload
        expect(assigns(:answer)).to eq answer
      end
      
      it 'choose the best answer' do
        patch :best, id: answer, question_id: question, format: :js
        answer.reload
        expect(answer.best).to eq true
      end
      
      it 'choose other best answer' do
        patch :best, id: answer2, question_id: question, format: :js
        answer2.reload
        answer.reload
        
        expect(answer2.best).to eq true
        expect(answer.best).to eq false
      end
      
      it 'render best template' do
        expect(response).to render_template :best
      end
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
