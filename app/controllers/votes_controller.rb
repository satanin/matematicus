class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:vote_up_question, :vote_down_question]
  before_action :set_answer, only: [:vote_up_answer, :vote_down_answer]

  def vote_up_question
    Vote.for_question @question.id, current_user.id, Vote::VOTE_UP
    update_question_view
  end

  def vote_down_question
    Vote.for_question @question.id, current_user.id, Vote::VOTE_DOWN
    update_question_view
  end

  def vote_up_answer
    Vote.for_answer @answer.id, current_user.id, Vote::VOTE_UP
    update_answer_view
  end

  def vote_down_answer
    Vote.for_answer @answer.id, current_user.id, Vote::VOTE_DOWN
    update_answer_view
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def update_question_view
    render "votes/update_question_votes"
  end

  def update_answer_view
    render "votes/update_answer_votes"
  end
end
