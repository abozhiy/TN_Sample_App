require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  
  describe "GET #index" do

    let(:questions) { create_list(:question, 2, user: user) }

    before { get :index }

    it "populates an array by all questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    before { get :show, id: question }

    it "assigns a requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "renders show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    sign_in_user

    before { get :new }

    it "assigns a new question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "assigns a new attachment for question" do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    sign_in_user

    context "Authenticated user creates question with valid attributes" do


      it "saves a new question to the database" do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'associates with current user' do
        expect { post :create, question: attributes_for(:question) }.to change(user.questions, :count).by(1)
      end

      it "redirects to show view" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "Authenticated user tries to create question with invalid attributes" do

      it "doesn't save a new question to the database" do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it "re-renders new view" do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    sign_in_user

    it "assigns the requested question to @question" do
      patch :update, id: question, question: attributes_for(:question), format: :js
      expect(assigns(:question)).to eq question
    end

    it "changes question attributes" do
      patch :update, id: question, question: { title: "new title", body: "new body" }, format: :js
      expect(question.reload.title).to eq "new title"
      expect(question.reload.body).to eq "new body"
    end

    it "render update template" do
      patch :update, id: question, question: attributes_for(:question), format: :js
      expect(response).to render_template :update
    end
  end

  describe "DELETE #destroy" do
    sign_in_user

    context 'Delete own question' do
      let!(:question) { create(:question, user: user) }

      
      it "deletes question" do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it "redirects to index view" do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'Delete other question' do
      let!(:another_user) { create(:user) }
      let!(:another_question) { create(:question, user: another_user) }

      it 'cannot delete other question' do
        expect { delete :destroy, id: another_question }.to_not change(Question, :count)
      end
    end
  end
end
