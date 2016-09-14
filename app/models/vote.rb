class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates :user_id,  presence: true
  validates :rating, inclusion: { in: -1..1 }
end
