module EventsHelper
  def friendly_date(event)
    if event.event_date.year != this_year
      event.event_date.in_time_zone(system_timezone).strftime('%B %d, %Y')
    else
      event.event_date.in_time_zone(system_timezone).strftime('%B %d')
    end
  end

  def friendly_time(event)
    event.event_date.in_time_zone(system_timezone).strftime('%l:%M %p')
  end

  private

  def system_timezone
    'Eastern Time (US & Canada)'
  end

  def this_year
    Date.today.year
  end
end
