class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :question_id, :user_id, :body, presence: true

  accepts_nested_attributes_for :attachments

  default_scope { order(best: :desc, created_at: :asc) }
  scope :best, -> { where(best: true) }

  def set_best
    Answer.transaction do
      old_best = self.question.answers.first
      old_best.update!(best: false) if old_best
      update!(best: true)
    end
  end
end
