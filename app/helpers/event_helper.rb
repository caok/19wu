module EventHelper

  def time_merge(event)
    start_time = event.start_time
    end_time = event.end_time
    text = start = I18n.localize(start_time, :format => format_year(start_time)) # http://j.mp/11ycCAB
    unless end_time.nil?
      format = if same_day?(start_time, end_time)
                 same_noon?(start_time, end_time) ? :time : :noon_time
               else
                 format_year(end_time)
               end
      text += " - #{I18n.localize(end_time, :format => format)}"
    end
    text
  end

  def group_event_path(event)
    group = event.group
    (event == group.events.latest.first) ? slug_event_path(group.slug) : url_for(
      :controller => 'events',
      :action => 'show',
      :id => event.id
    )
  end

  def event_follow_info(event)
    entry = [ event.group.followers_count, t('views.follow.state'), false ]
    entry[2] = true if current_user.try(:following?, event.group)
    entry.to_json
  end

  def event_join_info(event)
    entry = [t('views.join.state'), false]
    entry[1] = true if event.has?(current_user)
    entry.to_json
  end

  private
  def format_year(time)
    (time.year == Time.zone.now.year) ? :stamp : :stamp_with_year
  end

  def same_day?(time1, time2)
    time1.to_date == time2.to_date
  end

  def same_noon?(time1, time2)
    time1.strftime('%P') == time2.strftime('%P')
  end

end
