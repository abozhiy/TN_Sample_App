module Votable
  
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def set_vote_up
    self.votes.update(rating: 1)
  end

  def set_vote_down
    self.votes.update(rating: -1)
  end
end
