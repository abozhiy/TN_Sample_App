require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

let(:user) { create(:user) }
let(:another_user) { create(:user) }
let!(:question) { create(:question, user: another_user) }
let!(:answer) { create(:answer, question: question, user: another_user) }


describe "POST #create" do
  sign_in_user


  describe 'Question comment' do

    let!(:object) { create(:question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: question, user: user) }
    it_behaves_like 'Create comment'
  end


  describe 'Answer comment' do

    let!(:object) { create(:answer, question: question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: answer, user: user) }
    it_behaves_like 'Create comment'
  end
end



describe "PATCH #update" do
  sign_in_user


  describe 'Question comment' do

    let!(:object) { create(:question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: question, user: user) }
    it_behaves_like 'Update comment'
  end


  describe 'Answer comment' do

    let!(:object) { create(:answer, question: question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: answer, user: user) }
    it_behaves_like 'Update comment'
  end
end



describe "DELETE #destroy" do
  sign_in_user


  describe 'Question comment' do

    let!(:object) { create(:question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: question, user: user) }
    let!(:object_comment2) { create(:comment, commentable: question, user: another_user) }
    it_behaves_like 'Delete comment'
  end


  describe 'Answer comment' do

    let!(:object) { create(:answer, question: question, user: another_user) }
    let!(:object_comment) { create(:comment, commentable: answer, user: user) }
    let!(:object_comment2) { create(:comment, commentable: answer, user: another_user) }
    it_behaves_like 'Delete comment'
  end
end
end