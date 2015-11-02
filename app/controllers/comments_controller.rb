class CommentsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :destroy]
  before_action :set_user, only: [:new, :create, :destroy]
  before_action :set_question, only: [:new, :create, :destroy]

  def new
    @comment = Comment.new
    unless params[:answer_id].nil?
      @answer = Answer.find(params[:answer_id])
      @environment_variables = [@question, @answer, @comment]
    else
      @environment_variables = [@question,@comment]
    end
  end

  def create
    @comment = Comment.new(post_params)
    @comment.user_id = @user.id

    unless params[:answer_id].nil?
      @answer = Answer.find(params[:answer_id])
      @comment.answer_id = @answer.id
    else
      @comment.question_id = @question.id
    end

    if @comment.save
      redirect_to question_path(@question), notice: "#{t(:created, scope: :comments)}"
    else
      render :new
    end
  end

  def update
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

  def post_params
    params.require(:comment).permit(:body)
  end
end
