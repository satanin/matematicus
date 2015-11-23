module UsersHelper

  def user_can_edit_profile current_user, profile
    unless current_user.nil?
      return true if current_user.id == profile.id
    end
    false
  end
end
