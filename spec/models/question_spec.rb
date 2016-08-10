require 'rails_helper'

RSpec.describe Question, type: :model do

  before { @question = Question.new(title: "Any string", body: "Any text") }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:answers)}

  it { should be_valid }

  describe "when title is not present" do
    before { @question.title = " " }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { @question.body = " " }
    it { should_not be_valid }
  end
end