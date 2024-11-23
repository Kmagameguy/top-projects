module ApplicationHelper
  # Takes a string and adds a possessive modifier to it.
  # e.g. "Bob" becomes "Bob's" and "Jess" becomes "Jess'"
  # Naive implentation, but it works for now.
  def possessive(name)
    name + ('s' == name[-1,1] ? "'" : "'s")
  end

  def link_to_user_profile(user)
    link_to user.name, user_posts_path(user)
  end
end
