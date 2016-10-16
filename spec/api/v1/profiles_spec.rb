require 'rails_helper'

describe 'Profile API' do

  describe 'GET /me' do

    it_behaves_like "API Authenticable"
  
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it_behaves_like 'API success authorized'

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end
      
      it_behaves_like 'API request does not contain password'
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', { format: :json }.merge(options)
    end
  end


  describe "GET #index" do

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:users) { create_list(:user, 3) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it_behaves_like 'API success authorized'

      it 'does not contains me' do
        expect(response.body).to_not include_json(me.to_json)
      end

      it 'contains a list of all users' do
        expect(response.body).to be_json_eql(users.to_json)
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(users.first.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
      
      it_behaves_like 'API request does not contain password'
    end

    def do_request(options = {})
      get '/api/v1/profiles', { format: :json }.merge(options)
    end
  end
end
