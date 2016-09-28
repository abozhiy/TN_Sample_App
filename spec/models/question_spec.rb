require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) { create(:question) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should accept_nested_attributes_for :attachments }
  
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }


  describe 'votes_count' do

    it "should return a count of votes" do
      expect(question.votes_count).to eq (0)
    end
  end


  describe 'vote_up' do

    it "should to set votes count to eq 1" do
      question.vote_up(user)
      expect(question.votes).to eq question.votes(rating: 1)
    end
  end


  describe 'vote_down' do

    it "should to set votes count to eq -1" do
      question.vote_down(user)
      expect(question.votes).to eq question.votes(rating: -1)
    end
  end


  describe 'vote_cancel' do

    it "should to set votes count to eq 0" do
      question.vote_cancel(user)
      expect(question.votes).to eq question.votes(rating: 0)
    end
  end
end
