require 'rails_helper'

describe 'Questions API' do

  describe 'GET /index' do

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2, user: user) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question, user: user) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it_behaves_like 'API success authorized'
      it_behaves_like 'API returns list of subject'

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      it 'contains short_title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end
      
        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/questions', { format: :json }.merge(options)
    end
  end


  describe 'GET /show' do

    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:comment) { create(:comment, commentable: question) }
      let!(:attachment) { create(:attachment, attachable: question) }

      before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

      it_behaves_like 'API Commentable'
      it_behaves_like 'API Attachable'
      it_behaves_like 'API success authorized'

      %w(id title body created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}", { format: :json }.merge(options)
    end  
  end


  describe 'POST /create' do

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, user: user) }
      let(:access_token) { create(:access_token) }

      it 'saves a new question to the database' do
        expect { post "/api/v1/questions", question: attributes_for(:question), format: :json, access_token: access_token.token }.to change(Question, :count).by(1)
      end

      it 'associates with current user' do
        post "/api/v1/questions", question: attributes_for(:question), format: :json, access_token: access_token.token
        expect(assigns(:question).user.id).to eq access_token.resource_owner_id
      end
    end

    def do_request(options = {})
      post "/api/v1/questions", { question: attributes_for(:question), format: :json }.merge(options)
    end
  end
end
