require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:question) { create(:question) }
  let(:answer) { build(:answer, question: question) }

  it { should validate_presence_of :question_id }
  it { should validate_presence_of :body }
  it { should belong_to :question }
end
