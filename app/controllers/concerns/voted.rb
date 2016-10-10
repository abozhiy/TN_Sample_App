module Voted
  
  extend ActiveSupport::Concern

  
  included do
    before_action :load_votable, only: [:vote_up, :vote_down, :vote_cancel]
    authorize_resource
  end
 
  def vote_up
    @votable.vote_up(current_user) if @votable.votes_count < 1
    render json: { votes_count: @votable.votes_count, id: @votable.id  }
  end

  def vote_down
    @votable.vote_down(current_user) if @votable.votes_count > -1
    render json: { votes_count: @votable.votes_count, id: @votable.id  }
  end

  def vote_cancel
    @votable.vote_cancel(current_user)
    render json: { votes_count: @votable.votes_count, id: @votable.id  }
  end

  private
 
    def model_klass
      controller_name.classify.constantize
    end
 
    def load_votable
      @votable = model_klass.find(params[:id])
    end
end

