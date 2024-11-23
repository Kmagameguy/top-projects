module ApplicationHelper
  def link_to_user_profile(user)
    link_to user.name, user_path(user)
  end
end
