class AnswersController < ApplicationController
  before_action :answer_for_question, :set_user

  def new
    @answer = Answer.new
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
end
