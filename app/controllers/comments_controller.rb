class CommentsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :destroy]
  before_action :set_user, only: [:new, :edit, :create, :destroy]
  before_action :set_question, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    unless params[:answer_id].nil?
      @answer = Answer.find(params[:answer_id])
      @environment_variables = [@question, @answer, @comment]
      puts "*"*20,@environment_variables
    else
      @environment_variables = [@question,@comment]
      puts "*"*20,@environment_variables
    end
  end

  def edit
    unless params[:answer_id].nil?
      @answer = Answer.find(params[:answer_id])
      @environment_variables = [@question, @answer, @comment]
    else
      @environment_variables = [@question,@comment]
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @user.id

    unless params[:answer_id].nil?
      @answer = Answer.find(params[:answer_id])
      @comment.answer_id = @answer.id
    else
      @comment.question_id = @question.id
    end

    if @comment.save
      redirect_to question_path(@question), notice: "#{t(:successfully_created, scope: :comments)}"
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to question_path(@question), notice: "#{t(:successfully_edited, scope: :comments)}"
    else
      render :edit
    end
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
    params.require(:comment).permit(:body)
  end
end
