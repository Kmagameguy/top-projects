class EventAttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_attendance][:attended_event_id])
    @event.attendees << current_user
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.attendees.destroy(current_user)
    redirect_to event_path(@event)
  end
end
