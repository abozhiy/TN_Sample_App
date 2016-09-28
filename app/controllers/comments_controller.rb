class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: [:update, :destroy]
  before_action :load_commentable, only: [:create]
  
  def create
    @comment = @commentable.comments.build(comment_params.merge(user_id: current_user.id))
    if @comment.save
      PrivatePub.publish_to channel, comment: @comment.to_json
      render nothing: true
    else
      render nothing: false
    end
  end

  def update
    if current_user.author_of?(@comment)
      @comment.update(comment_params)
      render json: { body: @comment.body, id: @comment.id  }
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
