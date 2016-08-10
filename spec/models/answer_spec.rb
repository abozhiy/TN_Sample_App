require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:question) { FactoryGirl.create(:question) }
  let(:answer) { FactoryGirl.build(:answer, question: question) }

  it { should validate_presence_of :question_id }
  it { should validate_presence_of :body }

  describe "when question_id is not present" do
    before { answer.question_id = nil }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { answer.body = " " }
    it { should_not be_valid }
  end
end
