require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  
  describe "GET #index" do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it "populate an array by all questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    before { get :show, id: question }

    it "assigns a requested question to the variable @question" do
      expect(assigns(:question)).to eq question
    end

    it "render show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do

    before { get :new }

    it "assigns a new question to the variable @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "render new view" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do

    before { get :edit, id: question }

    it "assigns a requested question to the variable @question" do
      expect(assigns(:question)).to eq question
    end

    it "render edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do

    context "create with valid attributes" do

      it "save a new question to the database" do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it "redirect to show view" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context "create with invalid attributes" do

      it "doesn't save a new question to the database" do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it "re-render new view" do
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

      it "change attributes question" do
        patch :update, id: question, question: { title: "new title", body: "new body" }
        expect(question.title).to eq "new title"
        expect(question.body).to eq "new body"
      end

      it "redirect to updated question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context "with invalid attributes" do

      it "doesn't change attributes" do
        patch :update, id: question, question: { title: "new title", body: nil }
        expect(question.title).to eq "MyString"
        expect(question.body).to eq "MyText"
      end

      it "re-render edit view" do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before { question }

    it "deletes question" do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it "redirect to index view" do
      delete :destroy, id: question
      expect(response).to redirect_to question_path
    end
  end
end