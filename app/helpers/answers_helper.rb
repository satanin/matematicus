module AnswersHelper

  def user_can_vote_answer? current_user, answer
    return false unless current_user
    user_vote = Vote.find_by(user_id: current_user.id, answer_id: answer.id)
    user_vote.nil?
  end

  def user_can_vote answer
    user_vote = Vote.find_by(user_id: current_user.id, answer_id: answer.id) if current_user

    html = content_tag(:div, class:"large-1 columns vote-controls", id:"answer#{answer.id}-vote-controls") do
        concat "<i class='fa fa-chevron-up'></i>".html_safe
        concat "<h3><div id='votes-for-answer-#{answer.id}' >#{answer.votes_value}</div></h3>".html_safe
        concat "<i class='fa fa-chevron-down'></i>".html_safe
      end
    if user_vote.nil?
      html = content_tag(:div, class:"large-1 columns vote-controls", id:"answer#{answer.id}-vote-controls") do
          concat link_to("<i class='fa fa-chevron-up'></i>".html_safe, vote_up_answer_path(answer), remote: true)
          concat "<h3><div id='votes-for-answer-#{answer.id}' >#{answer.votes_value}</div></h3>".html_safe
          concat link_to("<i class='fa fa-chevron-down'></i>".html_safe, vote_down_answer_path(answer), remote: true)
        end
    end

    return html
  end

  def select_answer_controls answer,question, user
    puts "="*20, user.admin?
    user_can_vote = user.admin?
    html = content_tag(:div, class:"large-12 columns select-controls#{answer.id if answer.selected} select-controls", id:"select-answer-#{answer.id}") do
        concat "<i class='fa fa-check green'>#{t(:select, scope: :answers)}</i>".html_safe if answer.selected
      end

    if user_can_vote 
      html = content_tag(:div, class:"large-12 columns select-controls#{answer.id if answer.selected} select-controls", id:"select-answer-#{answer.id}") do
        concat link_to "<i class='fa fa-check green'>#{t(:select, scope: :answers)}</i>".html_safe, select_answer_path(question, answer), remote: true
      end
    end
  end
end
