class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_user, only: [:new, :create, :destroy]

  def index
    @questions = @user.questions
  end

  def show
    @question = Question.find(params[:id])
    @question.update_attributes(times_viewed: @question.times_viewed +=1 )
    @answers = @question.answers
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
end
