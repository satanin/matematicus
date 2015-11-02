class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
  before_action :set_user, only: [:index, :new, :create, :destroy]
  before_action :set_question, only: [:show, :edit, :update]

  def index
    @questions = @user.questions
  end

  def show
    @question.update_attributes(times_viewed: @question.times_viewed +=1 )
    @answers = @question.answers
  end

  def edit
  end

  def update
    if @question.update(post_params)
      redirect_to question_path(@question), notice: "t(:successfully_edited, scope: :questions)"
    else
      render :edit
    end
  end 

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(post_params)
    @question.user_id = @user.id

    if @question.save
      redirect_to question_path(@question), notice: "#{t(:created, scope: :questions)}"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:question).permit(:title, :body)
  end

  def set_user
    @user = current_user
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
