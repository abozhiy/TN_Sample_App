require 'rails_helper'

RSpec.describe Answer, type: :model do

  before { @answer = Answer.new(body: "Any text", question_id: question_id) }

  subject { @answer }

  it { should respond_to(:body) }
  it { should respond_to(:question_id) }
  it { should respond_to(:question) }

  it { should be_valid }

  describe "when body is not present" do
    before { @answer.body = " " }
    it { should_not be_valid }
  end

  describe "when question_id is not present" do
    before { @answer.question_id = nil }
    it { should_not be_valid }
  end
end
