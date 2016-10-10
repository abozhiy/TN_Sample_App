require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end


  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end


  describe 'for user' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    
    context 'create' do
      it { should be_able_to :create, Question }
      it { should be_able_to :create, Answer }
      it { should be_able_to :create, Comment }
    end

    context 'update' do
      it { should be_able_to :update, create(:question, user: user), user: user }
      it { should_not be_able_to :update, create(:question, user: another_user), user: user }

      it { should be_able_to :update, create(:answer, question: question, user: user), user: user }
      it { should_not be_able_to :update, create(:answer, question: question, user: another_user), user: user }

      it { should be_able_to :update, create(:comment, user: user), user: user }
      it { should_not be_able_to :update, create(:comment, user: another_user), user: user }
    end

    context 'destroy' do
      it { should be_able_to :destroy, create(:question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:question, user: another_user), user: user }

      it { should be_able_to :destroy, create(:answer, question: question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:answer, question: question, user: another_user), user: user }

      it { should be_able_to :destroy, create(:comment, user: user), user: user }
      it { should_not be_able_to :destroy, create(:comment, user: another_user), user: user }
    end

    context 'votes for question' do
      it { should_not be_able_to :vote_up, create(:question, user: user), user: user }
      it { should_not be_able_to :vote_down, create(:question, user: user), user: user }

      it { should be_able_to :vote_up, create(:question, user: another_user), user: user }
      it { should be_able_to :vote_down, create(:question, user: another_user), user: user }

      it { should be_able_to :vote_cancel, create(:vote, votable: question, user: user), user: user }
    end
      
    context 'votes for answer' do
      it { should_not be_able_to :vote_up, create(:answer, question: question, user: user), user: user }
      it { should_not be_able_to :vote_down, create(:answer, question: question, user: user), user: user }

      it { should be_able_to :vote_up, create(:answer, question: question, user: another_user), user: user }
      it { should be_able_to :vote_down, create(:answer, question: question, user: another_user), user: user }

      it { should be_able_to :vote_cancel, create(:vote, votable: answer, user: user), user: user }
    end

    context 'best answer' do
      it { should be_able_to :best, create(:answer, question: question, user: user), user: question.user }
    end

    context 'question attachment' do
      it { should be_able_to :destroy, create(:attachment, attachable: question), user: user }
    end

    context 'answer attachment' do
      it { should be_able_to :destroy, create(:attachment, attachable: answer), user: user }
    end
  end
end
