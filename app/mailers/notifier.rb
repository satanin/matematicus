class Notifier < ApplicationMailer

  def answer_created(answer, question)
    @user = question.user
    @user_answering = answer.user
    @question = question
    @answer 
    mail(to: @user.email, subject: "#{t(:subject, scope: [:notifier, :answer_created], user_name: @user_answering.username)}")
  end
end
