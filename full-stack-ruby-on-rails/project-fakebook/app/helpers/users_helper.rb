module UsersHelper
  def pending_friend_request?(user)
    FriendRequest.where("friend_id = ? AND user_id = ?", current_user.id, user.id).any?
  end
end
