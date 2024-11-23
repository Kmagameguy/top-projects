module UsersHelper
  def own_event?(event)
    current_user.created_events.include?(event)
  end

  def user_attending?(event)
    current_user.attended_events.include?(event)
  end

  def not_own_event?(event)
    !own_event?(event)
  end
end
