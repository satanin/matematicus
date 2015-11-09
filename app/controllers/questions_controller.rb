class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update]
  before_action :set_user, only: [:index, :new, :create, :destroy]
  before_action :set_question, only: [:show, :edit, :update]

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
    puts "*"*20, question_params
    @question_tag_ids = question_params[:tag_ids]
    puts "*"*20, @question_tag_ids

    @question.update!(question_params)
    QuestionTag.associate_tags_to_question @question, @question_tag_ids

    redirect_to question_path(@question), notice: "#{t(:successfully_edited, scope: :questions)}"

    rescue Exception
    render :edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = @user.id
    @question_tag_ids = post_params[:tag_ids]

    @question.save!
    QuestionTag.associate_tags_to_question @question, @question_tag_ids

    redirect_to question_path(@question), notice: "#{t(:created, scope: :questions)}"

    rescue Exception
    render :new
  end

  private

  def question_params
    params.require(:question).permit(:title, :body,  :tag_ids => [])
  end

  def set_user
    @user = current_user
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
