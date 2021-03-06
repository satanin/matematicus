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
    @selected_answer = @answers.where(selected: true)
    @answers = @answers - @selected_answer
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
    @question = Question.for @user.id, post_params
    flash[:success] = "#{t(:created, scope: :questions)}"

    redirect_to question_path(@question)
  rescue Exception
    render :new
  end

  def tagged
    @questions = Question.tagged_with @tag.id
  end

  def select_answer
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(params[:question_id])

    clear_previous_answer_for @question


    @answer.selected = true
    @answer.save
    @answers = @question.answers
    update_question_view
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
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "#{t(:invalid, scope: :questions)}" if @question.nil?
  end

  def set_tag
    @tag = Tag.find_by(name: params[:name])

    redirect_to root_path, alert: "#{t(:invalid, scope: :tags)}" if @tag.nil?
  end

  def vote_controls_for_user
    return 'user_can_vote' if can_vote
    return 'user_cannot_vote'
  end

  def can_vote
    return false unless current_user
    user_vote = @question.votes.find_by(user_id: current_user.id)
    user_vote.nil?
  end

  def update_question_view
    render "questions/update_question"
  end

  def clear_previous_answer_for question
    current_answer = question.answers.select { |q| q.selected == true }.first
    current_answer.update_attribute(:selected,false) if current_answer
  end

end
