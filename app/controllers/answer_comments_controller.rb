class AnswerCommentsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :destroy]
  before_action :set_user, only: [:new, :edit, :create, :destroy]
  before_action :set_question, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_answer, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = AnswerComment.new
  end

  def edit
  end

  def create
    @comment = AnswerComment.new(comment_params)
    @comment.user_id = @user.id
    @comment.answer_id = @answer.id
    @comment.save!
    flash[:success]=  "#{t(:successfully_created, scope: :comments)}"
    redirect_to question_path(@question)

    rescue Exception
    render :new
  end

  def update
    @comment.update!(comment_params)
    flash[:success]=  "#{t(:successfully_edited, scope: :comments)}"
    redirect_to question_path(@question)

    rescue Exception
    render :edit
  end

  def delete
  end

  private

  def set_user
    @user = current_user
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def set_comment
    @comment = AnswerComment.find(params[:id])
  end

  def comment_params
    params.require(:answer_comment).permit(:body)
  end
end
