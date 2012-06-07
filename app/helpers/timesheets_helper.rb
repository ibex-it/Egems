module TimesheetsHelper

  def timesheet_navs(active_time)
    active_time ||= Time.now.beginning_of_day
    if active_time.is_a?(Range)
      active_range = "active"
      active_time = active_time.first
    end

    tabs = []
    current = active_time.localtime.monday
    week_end = current.sunday
    nav = %Q{
      <ul class="nav nav-tabs" id="myTab">
      <li class="#{active_range} pull-right">
        <a href="#{timesheets_nav_week_path(:time => current)}" data-method="post">Week</a>
      </li>
    }
    until current > week_end do
      day_full = current.strftime("%A")
      day_abbr = current.strftime("%a")
      active = (active_time.to_date.eql?(current.to_date) && !active_range ? "active" : nil)
      tabs.prepend(%Q{
        <li class="#{active} pull-right">
          <a href="#{timesheets_nav_path(:time => current)}" data-method="post">#{day_abbr}</a>
        </li>
      })
      current += 1.day
    end
    nav += (tabs.join(" ") << "</ul>")
    nav.html_safe
  end
  
  def total_hours(timesheets)
    total_mins = 0
    str = []
    if timesheets.any? && timesheets.last.duration > 0
      timesheets.each do |timesheet|
        total_mins += timesheet.duration
      end
      hrs = (total_mins / 60).to_i
      mins = (total_mins - (hrs * 60)).to_i
      str << "#{hrs}hr(s)" if hrs > 0
      str << "#{mins}min(s)" if mins > 0
    end
    str.join(" ")
  end
end
