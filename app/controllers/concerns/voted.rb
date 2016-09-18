module Voted
  
  extend ActiveSupport::Concern
  
  included do
    before_action :set_votable, only: [:vote_up, :vote_down, :vote_cancel]
  end
 
  def vote_up
    unless current_user.author_of?(@votable) 
      unless current_user.voted?(@votable)
        @votable.set_vote_up(current_user)
        render json: { votes_count: @votable.votes_count }
      end
    end
  end

  def vote_down
    unless current_user.author_of?(@votable) 
      unless current_user.voted?(@votable)
        @votable.set_vote_down(current_user)
        render json: { votes_count: @votable.votes_count }
      end
    end
  end

  def vote_cancel
    if current_user.voted?(@votable)
      @votable.set_vote_cancel(current_user)
      render json: { votes_count: @votable.votes_count }
    end
  end

  private
 
    def model_klass
      controller_name.classify.constantize
    end
 
    def set_votable
      @votable = model_klass.find(params[:id])
    end
end

