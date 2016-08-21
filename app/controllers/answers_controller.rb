class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Your answer successfuly posted."
      redirect_to @question
    else
      render :new
    end
  end

  def update
    @answer = Answer.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      flash[:notice] = "Your answer successfuly updated."
    else
      flash[:notice] = "Your cannot edit alien answer!"
    end
      redirect_to @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = "Your answer successfuly deleted."
    else
      flash[:notice] = "Your cannot delete alien answer!"
    end
      redirect_to @answer.question
  end


  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
