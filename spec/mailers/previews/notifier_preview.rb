# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  def answer_created
    @question = Question.first
    @answer = Answer.first
    Notifier.answer_created(@question, @answer)
  end

end
