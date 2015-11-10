module QuestionsHelper
  def outside_question_view
    /\/questions\/[0-9]/.match(request.env['PATH_INFO']).nil?
  end
end
