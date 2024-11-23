class EventsController < ApplicationController
  def new
    @event = Event.new
    @time_now = Time.new.strftime('%Y-%m-%dT%k:%M')
  end

  def index
    @events = Event.all
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_date)
  end
end
