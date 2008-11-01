module HomeHelper
  def calendar_classes_of(date, current_month)
    classes = ""
    classes += "today" if date == Date.today
    classes += " weekend" if date.wday == 6 || date.wday == 0
    classes += " other_month" if date.month != current_month
    classes
  end
end
