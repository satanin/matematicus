class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
  before_action :set_user, only: [:index, :new, :create, :destroy]
  before_action :set_question, only: [:show, :edit, :update]
  before_action :set_tag, only: [:tagged]

  def index
    @questions = @user.questions
  end

  def show
    @question.increase_views
    @answers = @question.answers
    @answer = Answer.new
  end

  def edit
  end

  def update
    @question.update!(post_params)
    redirect_to question_path(@question), notice: "#{t(:successfully_edited, scope: :questions)}"

  rescue Exception
    render :edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(post_params)
    @question.user_id = @user.id

    @question.save!
    redirect_to question_path(@question), notice: "#{t(:created, scope: :questions)}"

  rescue Exception
    render :new
  end

  def tagged
    @questions = Question.tagged_with @tag
  end

  private

  def post_params
    params.require(:question).permit(:title, :body, tag_ids:[])
  end

  def set_user
    @user = current_user
  end

  def set_question
    @question = Question.find(params[:id])

  rescue Exception
    redirect_to root_path, alert: "#{t(:invalid, scope: :questions)}" if @question.nil?
  end

  def set_tag
    @tag = Tag.find_by(name: params[:name])

    redirect_to root_path, alert: "#{t(:invalid, scope: :tags)}" if @tag.nil?
  end
end
