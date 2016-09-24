class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: [:update, :destroy]
  before_action :load_commentable, only: [:create]
  
  def create
    @comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id))
  end

  def update
    if current_user.author_of?(@comment)
      @comment.update(comment_params)
    end
  end

  def destroy
    if current_user.author_of?(@comment)
      @comment.destroy
    end
  end

  private
    
    def load_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def commentable_type
      params[:commentable_type]
    end

    def commentable
      commentable_type.classify.constantize
    end

    def load_commentable
      @commentable = commentable.find(params["#{commentable_type}_id"])
    end
end
