module PostsHelper
  def posts_owner?(user)
    user == current_user
  end
end
