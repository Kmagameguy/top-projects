module LikesHelper
  def already_liked?(likeable)
    current_user.likes.any? { |like| likeable.likes.pluck(:user_id).include?(like.likeable_id) }
  end

  def liked_by(likeable)
    likeable.likes.pluck(:user_id).map { |id| User.find(id).name }.join(', ')
  end
end
