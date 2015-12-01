class QuestionCommentsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :destroy]
  before_action :set_user, only: [:new, :edit, :create, :destroy]
  before_action :set_question, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = QuestionComment.new
  end

  def edit

  end

  def create
    @comment = QuestionComment.new(comment_params)
    @comment.user_id = @user.id
    @comment.question_id = @question.id
    @comment.save!
    flash[:success]= "#{t(:successfully_created, scope: :comments)}"
    redirect_to question_path(@question)

    rescue Exception
    render :new
  end

  def update
    @comment.update!(comment_params)
    flash[:success]= "#{t(:successfully_edited, scope: :comments)}"
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

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:question_comment).permit(:body)
  end
end
