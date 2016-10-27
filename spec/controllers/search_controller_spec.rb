require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #index" do

    let(:params) { { q: 'query', scope: 'Question' } }

    it "searching content with ThinkingSphinx" do
      expect(ThinkingSphinx).to receive(:search).with('query', classes: [Question]).and_call_original
      get :index, params: params
    end
  end
end
