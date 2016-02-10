class WelcomeController < ApplicationController

  def index
    @questions = Question.ordered_by_answer_date
    @most_viewed_questions = Question.most_viewed
    @most_voted_answers = Answer.most_voted
  end

end
