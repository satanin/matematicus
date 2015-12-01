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
    @vote_controls = vote_controls_for_user
    @comment = QuestionComment.new
    @answer_comment = AnswerComment.new
  end

  def edit
  end

  def update
    @question.update!(post_params)
    flash[:success]="#{t(:successfully_edited, scope: :questions)}"
    redirect_to question_path(@question)
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
    flash[:success]="#{t(:created, scope: :questions)}"
    redirect_to question_path(@question)

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

  def vote_controls_for_user
    return 'user_cannot_vote' unless current_user
    user_vote = @question.votes.find_by(user_id: current_user.id)
    return 'user_can_vote' if user_vote.nil?
    return 'user_cannot_vote'
  end
end
