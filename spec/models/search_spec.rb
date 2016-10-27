require 'rails_helper'

RSpec.describe Search, type: :model do


  describe 'run' do

    context 'search in questions' do

      let(:params) { { q: 'query', scope: 'Question' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to receive(:search).with('query', classes: [Question]).and_call_original
        Search.run(params)
      end
    end


    context 'search in answers' do

      let(:params) { { q: 'query', scope: 'Answer' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to receive(:search).with('query', classes: [Answer]).and_call_original
        Search.run(params)
      end
    end


    context 'search in comments' do

      let(:params) { { q: 'query', scope: 'Comment' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to receive(:search).with('query', classes: [Comment]).and_call_original
        Search.run(params)
      end
    end


    context 'search in users' do

      let(:params) { { q: 'query', scope: 'User' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to receive(:search).with('query', classes: [User]).and_call_original
        Search.run(params)
      end
    end


    context 'search everywhere' do

      let(:params) { { q: 'query', scope: 'All' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to receive(:search).with('query', classes: []).and_call_original
        Search.run(params)
      end
    end


    context 'search with another scope' do

      let(:params) { { q: 'query', scope: 'Another' } }

      it 'searching question with ThinkingSphinx' do
        expect(ThinkingSphinx).to_not receive(:search).and_call_original
        Search.run(params)
      end
    end
  end
end

