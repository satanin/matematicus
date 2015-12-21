class WelcomeController < ApplicationController

  def index
    @questions = Question.order(answered_at: :desc)
    @most_viewed_questions = Question.order(times_viewed: :desc).limit(5)
    @most_voted_answers = Answer.all.sort_by{|answer| answer.votes_value }.reverse[0..4]
  end

end
