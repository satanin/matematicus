class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create]
  before_action :answer_for_question, :set_user
  before_action :set_answer, only: [:edit, :update]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def update
    @answer.update!(answer_params)
    Notifier.answer_created(@answer, @question).deliver_now
    flash[:success]=  "#{t(:successfully_edited, scope: :answers)}"
    redirect_to question_path(@question)

    rescue Exception
    render :edit
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = @user.id
    @answer.question_id = @question.id

    if @answer.save!
      Notifier.answer_created(@answer, @question).deliver_now
      flash[:success]=  "#{t(:successfully_created, scope: :answers)}"
      redirect_to question_path(@question)
    else
      render :new
    end
  end


  private
  def answer_for_question
    @question = Question.find(params[:question_id])
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
