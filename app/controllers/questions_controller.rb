class QuestionsController < ApplicationController
  
  before_action :authenticate_user!, except: [:show, :index]
  before_action :load_question, only: [:show, :update, :destroy]
  before_action :build_answer, only: :show
  after_action :publish_question, only: :create
  include Voted

  respond_to :js
  respond_to :json, only: :create

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answers = @question.answers
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def create
    respond_with(@question = Question.create(question_params.merge(user_id: current_user.id)))
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
      respond_with @question
    else
      flash[:notice] = "You cannot update alien questions."
    end
  end

  def destroy
    if current_user.author_of?(@question)
      respond_with(@question.destroy)
    else
      redirect_to @question, notice: "You cannot delete alien questions."
    end
  end


  private

  def load_question
    @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def publish_question
    PrivatePub.publish_to("/questions", question: @question.to_json) if @question.valid?
  end
    

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end
