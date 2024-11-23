module UsersHelper
  def user_attending?(event)
    current_user.created_events.include?(event) || current_user.attended_events.include?(event)
  end
end
