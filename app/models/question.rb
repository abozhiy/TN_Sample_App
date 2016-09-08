class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, inverse_of: :question
  validates :title, :body, :user_id, presence: true

  accepts_nested_attributes_for :attachments
end
