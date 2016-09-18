module Votable
  
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def votes_count
    votes.sum(:rating)
  end

  def set_vote_up(user)
    self.votes.create(user: user, rating: 1)
  end

  def set_vote_down(user)
    self.votes.create(user: user, rating: -1)
  end

  def set_vote_cancel(user)
    self.votes.where(user: user).delete_all
  end
end
