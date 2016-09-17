module Voted
  
  extend ActiveSupport::Concern
  
  included do
    before_action :set_votable, only: [:vote_up, :vote_down, :vote_cancel]
  end
 
  def vote_up
    if !current_user.author_of?(@votable) && !current_user.voted?(@votable)
      @votable.set_vote_up(current_user)
      render json: { id: @votable.id, type: @votable.type, rating: @votable.rating }
    end
  end

  def vote_down
    if !current_user.author_of?(@votable) && !current_user.voted?(@votable)
      @votable.set_vote_down(current_user)
      render json: { id: @votable.id, type: @votable.type, rating: @votable.rating }
    end
  end

  def vote_cancel
    if current_user.voted?(@votable)
      @vote.destroy
      flash[:notice] = "Your vote successfuly canceled."
      render json: { id: @votable.id, type: @votable.type, rating: @votable.rating }
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

