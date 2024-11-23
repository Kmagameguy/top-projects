class EventAttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_attendance][:attended_event_id])
    @event.attendees << current_user
    flash[:notice] = 'You have successfully joined the event.'

    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.attendees.destroy(current_user)
    flash[:notice] = 'You have successfully left the event.'

    redirect_to event_path(@event)
  end
end
