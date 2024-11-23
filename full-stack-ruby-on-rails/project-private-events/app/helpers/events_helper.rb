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

  def event_date_placeholder(event)
    return Time.new.in_time_zone(system_timezone).strftime('%Y-%m-%dT%k:%M') unless event.event_date

    event.event_date.in_time_zone(system_timezone).strftime('%Y-%m-%dT%k:%M')
  end

  private

  def system_timezone
    'Eastern Time (US & Canada)'
  end

  def this_year
    Date.today.year
  end
end
