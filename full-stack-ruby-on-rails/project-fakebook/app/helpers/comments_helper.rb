module CommentsHelper
  def comment_owner?(user)
    user == current_user
  end
end
