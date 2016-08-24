class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :load_question, except: [:index, :new, :create]

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
    @question = Question.new(question_params.merge(user_id: current_user.id))
    if @question.save
      redirect_to @question, notice: "Your question successfuly created."
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      if @question.update(question_params)
        redirect_to @question, notice: "Your question successfuly updated."
      else
        render :edit
      end
    else
      redirect_to @question, notice: "You cannot update alien questions."
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: "Your question successfuly deleted."
    else
      redirect_to @question, notice: "You cannot delete alien questions."
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
