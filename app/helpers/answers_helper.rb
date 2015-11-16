module AnswersHelper

  def user_can_vote_answer? current_user, answer
    return false unless current_user
    user_vote = Vote.find_by(user_id: current_user.id, answer_id: answer.id)
    user_vote.nil?
  end

  def user_can_vote answer
    user_vote = Vote.find_by(user_id: current_user.id, answer_id: answer.id)
    if user_vote.nil?
      content_tag(:div, class:"large-1 columns", id:"answer#{answer.id}-vote-controls") do
        concat link_to("<i class='fa fa-chevron-up'></i>".html_safe, vote_up_answer_path(answer), remote: true)
        concat "<h3><div id='votes-for-answer-#{answer.id}' >#{answer.votes_value}</div></h3><br />".html_safe
        concat link_to("<i class='fa fa-chevron-down'></i>".html_safe, vote_down_answer_path(answer), remote: true)
      end
    else
      content_tag(:div, class:"large-1 columns", id:"answer#{answer.id}-vote-controls") do
        concat "<i class='fa fa-chevron-up'></i>".html_safe
        concat "<h3><div id='votes-for-answer-#{answer.id}' >#{answer.votes_value}</div></h3><br />".html_safe
        concat "<i class='fa fa-chevron-down'></i>".html_safe
      end
    end
  end
end
