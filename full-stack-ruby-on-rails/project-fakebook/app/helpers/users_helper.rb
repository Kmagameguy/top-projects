module UsersHelper
  def pending_friend_request?(user)
    FriendRequest.where("friend_id = ? AND user_id = ?", current_user.id, user.id).any?
  end

  def gravatar_for(user)
    gravatar_url =
      Rails.cache.fetch("gravatar/#{user.id}", expires_in: 1.hour) do
        email = user.profile.email || ''
        gravatar_id = Digest::MD5.hexdigest(email)
        "https://secure.gravatar.com/avatar/#{gravatar_id}"
      end
    image_tag(gravatar_url, alt: user.name)
  end
end
