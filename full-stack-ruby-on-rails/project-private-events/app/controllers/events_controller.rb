class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_attendance = EventAttendance.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:notice] = 'Event created successfully.'
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = 'Event updated successfully.'
      redirect_to @event
    else
      flash.now[:alert] = 'Event update failed.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = 'Event deleted successfully.'
    redirect_to root_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_date)
  end
end
