class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, optional: true
  
  validates :user_id, :commentable_id, :body, presence: true
end
