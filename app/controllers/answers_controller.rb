class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy]

  def create
    @answer = @question.answers.create(answer_params.merge(user_id: current_user.id))
  end

  def update
    @question = @answer.question
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      flash[:notice] = "Your answer successfuly updated."
    else
      flash[:notice] = "Your cannot edit alien answer!"
    end
    redirect_to @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = "Your answer successfuly deleted."
    else
      flash[:notice] = "Your cannot delete alien answer!"
    end
  end


  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
