require 'rails_helper'

shared_examples 'voted' do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  describe 'PATCH #vote' do

    let(:another_user) { create(:user) }
    let!(:answer2) { create(:answer, question: question, user: another_user) }
    

    context 'Not-authenticated user' do

      it 'cannot vote for answer' do
        expect { patch :vote, id: answer, question_id: question, format: :js }.to_not change(Answer, :count)
      end
    end

    
    context "Authenticated user" do
      sign_in_user

      it 'assigns the requested answer_id to @answer' do
        patch :vote, id: answer, question_id: question, format: :js
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
end