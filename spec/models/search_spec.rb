require 'rails_helper'

RSpec.describe Search, type: :model do


  describe 'run' do

    let(:params) { { q: 'query', scope: 'Question' } }

    it 'searching content with ThinkingSphinx' do
      expect(ThinkingSphinx).to receive(:search).with('query', classes: [Question]).and_call_original
      Search.run(params)
    end
  end
end

