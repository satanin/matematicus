class Notifier < ApplicationMailer
  include Roadie::Rails::Automatic

  def answer_created(answer, question)
    @user = question.user
    @user_answering = answer.user
    @question = question
    @answer 
    @encrypted_email = encrypted_email
    mail(to: @user.email, subject: "#{t(:subject, scope: [:notifier, :answer_created], user_name: @user_answering.username)}")
  end

  private

  def encrypted_email
    crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY']) 
    crypt.encrypt_and_sign(@user.email)    
  end
end
