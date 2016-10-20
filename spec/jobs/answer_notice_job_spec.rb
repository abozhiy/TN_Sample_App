require 'rails_helper'

RSpec.describe AnswerNoticeJob, type: :job do
  
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: another_user) }

  it 'send notice to subscriber of question' do
    expect(AnswerNoticeMailer).to receive(:new_answer_notice).with(user).and_call_original
    AnswerNoticeJob.perform_now(answer)
  end
end
