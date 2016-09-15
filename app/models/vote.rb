class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true, optional: true

  validates :user_id, :votable_id, presence: true
  validates :rating, inclusion: { in: -1..1 }

end
