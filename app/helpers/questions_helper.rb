module QuestionsHelper
  def outside_question_view
    /\/questions\/[0-9]/.match(request.env['PATH_INFO']).nil?
  end

  def edit_question_toggle current_user, question  
    link_to "<i class='fa fa-pencil'></i>".html_safe, edit_question_path(question) if user_can_edit_question? current_user,question
  end

  def user_can_edit_question? current_user,question
    question.user == current_user
  end

  def user_can_vote? current_user,question
    user_vote = Vote.find_by(user_id: current_user.id, question_id: question.id)
    puts "*"*20, user_vote.nil?
    user_vote.nil?
  end
end
