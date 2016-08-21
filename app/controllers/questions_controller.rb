class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = "Your question successfuly created."
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      if @question.update(question_params)
        flash[:notice] = "Your question successfuly updated."
        redirect_to @question
      else
        render :edit
      end
    else
      flash[:error] = "You cannot update alien questions."
      redirect_to @question
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = "Your question successfuly deleted."
      redirect_to questions_path
    else
      flash[:error] = "You cannot delete alien questions."
      redirect_to @question
    end
  end


  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
