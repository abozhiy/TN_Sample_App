require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  
  describe "GET #index" do
    let(:questions) { create_list(:question, 2) }

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

    it "assigns a requested question to the variable @question" do
      expect(assigns(:question)).to eq question
    end

    it "renders show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do

    before { get :new }

    it "assigns a new question to the variable @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do

    before { get :edit, id: question }

    it "assigns a requested question to the variable @question" do
      expect(assigns(:question)).to eq question
    end

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do

    context "create with valid attributes" do


      it "saves a new question to the database" do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it "redirects to show view" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "create with invalid attributes" do

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

    context "update with valid attributes" do

      it "assigns a requested question to the variable @question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it "changes attributes question" do
        patch :update, id: question, question: { title: "new title", body: "new body" }
        expect(question.reload.title).to eq "new title"
        expect(question.reload.body).to eq "new body"
      end

      it "redirects to updated question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context "with invalid attributes" do
      
      before do
        patch :update, id: question, question: attributes_for(:invalid_question)
      end

      it "doesn't change attributes" do
        expect(question.title).to eq "MyString"
        expect(question.body).to eq "MyText"
      end

      it "re-renders edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before { question }

    it "deletes question" do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it "redirects to index view" do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end