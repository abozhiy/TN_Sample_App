class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    if @answer.save
      flash[:notice] = "Your answer successfuly posted."
      redirect_to @question
    else
      render :new
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
