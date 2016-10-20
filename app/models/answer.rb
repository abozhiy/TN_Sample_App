class Answer < ApplicationRecord
  include Votable
  include Commentable
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :question_id, :user_id, :body, presence: true

  after_create :subscribe_for_notice

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  default_scope { order(best: :desc, created_at: :asc) }
  scope :best, -> { where(best: true) }

  def set_best
    Answer.transaction do
      old_best = self.question.answers.first
      old_best.update!(best: false) if old_best
      update!(best: true)
    end
  end

  def subscribe_for_notice
    AnswerNoticeJob.perform_later(self)
  end
end
