require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) { FactoryGirl.create(:question) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  describe "when title is not present" do
    before { question.title = " " }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { question.body = " " }
    it { should_not be_valid }
  end
end