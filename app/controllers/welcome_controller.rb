class WelcomeController < ApplicationController

  def index
    @questions = Question.order(updated_at: :desc)
  end

end
