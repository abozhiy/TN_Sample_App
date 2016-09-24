require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }


  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  
  
  describe 'author_of?' do

    it "return true if user author of question/answer" do
      expect(user).to be_author_of(question)
    end
  end

  
  describe 'voted?' do

    it "should checking that user was voted" do
      question.votes.create(user: user, rating: 1)
      expect(user).to be_voted(question)
    end
  end
end
