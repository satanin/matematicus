class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def vote_up
    Vote.create(user_id: current_user.id, question_id: @question.id, value: Vote::VOTE_UP )
    update_view
  end

  def vote_down
    Vote.create(user_id: current_user.id, question_id: @question.id, value: Vote::VOTE_DOWN )
    update_view
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def update_view
    render "votes/update_votes"
  end

end
