class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :question_id, :user_id, :body, presence: true

  default_scope { order(best: :desc, created_at: :asc) }
  scope :best, -> { where(best: true) }
end
