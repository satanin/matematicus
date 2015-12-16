module QuestionsHelper

  def outside_question_view
    /\/questions\/[0-9]/.match(request.env['PATH_INFO']).nil?
  end

  def edit_question_toggle current_user, question
    link_to "<i class='fa fa-pencil'></i>".html_safe, edit_question_path(question) if user_can_edit? question, current_user
  end

  def show_question_comments? question
    question.question_comments.count >=1
  end

  def edit_question_comment_toggle current_user, question_comment
    link_to t(:edit_comment, scope: :comments), edit_question_question_comment_path(question_comment.question.id, question_comment) if user_can_edit? question_comment, current_user
  end

  def edit_answer_comment_toggle current_user, answer_comment
    link_to t(:edit_comment, scope: :comments), edit_question_answer_answer_comment_path(answer_comment.answer.question.id, answer_comment.answer.id, answer_comment) if user_can_edit? answer_comment, current_user
  end

  def user_can_edit? item, current_user
    item.user == current_user
  end
end
