require 'rails_helper'

describe 'Answers API' do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  

  describe 'GET #index' do

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:answers) { create_list(:answer, 2, question: question, user: user) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it_behaves_like 'API success authorized'
      it_behaves_like 'API returns list of subject'

      %w(id body created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end


    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end


  describe 'GET /show' do

    let!(:answer) { create(:answer, question: question, user: user) }

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:comment) { create(:comment, commentable: answer) }
      let!(:attachment) { create(:attachment, attachable: answer) }

      before { get "/api/v1/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it_behaves_like 'API Commentable'
      it_behaves_like 'API Attachable'
      it_behaves_like 'API success authorized'

      %w(id body created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/answers/#{answer.id}", {format: :json}.merge(options)
    end
  end


  describe 'POST /create' do

    it_behaves_like 'API Authenticable'

    context 'authorized' do
    
      let(:access_token) { create(:access_token) }

      it 'saves a new answer to the database' do
        expect { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json, access_token: access_token.token }.to change(Answer, :count).by(1)
      end

      it 'associates with current user' do
        post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json, access_token: access_token.token
        expect(assigns(:answer).user.id).to eq access_token.resource_owner_id
      end
    end

    def do_request(options = {})
      post "/api/v1/questions/#{question.id}/answers", {answer: attributes_for(:answer), format: :json}.merge(options)
    end
  end
end
