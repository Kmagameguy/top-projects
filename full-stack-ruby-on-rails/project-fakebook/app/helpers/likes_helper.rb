module LikesHelper
  def already_liked?(likeable)
    current_user.likes.any? { |like| like.likeable_id == likeable.id }
  end
end
