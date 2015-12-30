module ApplicationHelper

  def can_edit item
    item.user == current_user
  end
end
