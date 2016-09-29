class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: [:update, :destroy]
  before_action :load_commentable, only: :create
  after_action :publish_comment, only: :create

  respond_to :js
  respond_to :json, only: [:create, :update]
  
  def create
    respond_with(@comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id)))
  end

  def update
    if current_user.author_of?(@comment)
      @comment.update(comment_params)
      render json: { body: @comment.body, id: @comment.id  }
    end
  end

  def destroy
    if current_user.author_of?(@comment)
      respond_with(@comment.destroy)
    end
  end

  private
    
    def load_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def publish_comment
      PrivatePub.publish_to(channel, comment: @comment.to_json) if @comment.valid?
    end


    def load_commentable
      parent, id = request.path.split('/')[1, 2]
      @commentable = parent.singularize.classify.constantize.find(id)
    end

    def channel
      if @commentable.is_a? Question
        id = @commentable.id
      else
        id = @commentable.question.id
      end
      "/questions/#{id}/comments"
    end
end
