class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update]
  before_action :answer_for_question, :set_user
  before_action :set_answer, only: [:edit, :update]

  def new
    @answer = Answer.new
  end

  def edit
    
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: "#{t(:successfully_edited, scope: :answers)}"
    else
      render :edit
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = @user.id
    @answer.question_id = @question.id

    if @answer.save
      redirect_to user_question_path(@user,@question)
    else
      render :new
    end
  end


  private
  def answer_for_question
    @question = Post.find(params[:question_id])
  end

  def set_user
    @user = current_user
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
