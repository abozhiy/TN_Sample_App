require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) { create(:question) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end
