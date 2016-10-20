class Question < ApplicationRecord
  include Votable
  include Commentable
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  validates :title, :body, :user_id, presence: true

  after_create :subscribe_for_author

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  def subscribe_for_author
    user.subscribe(self)
  end
end
