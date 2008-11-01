module ApplicationHelper
  def calendar_classes_of(date, current_month)
    classes = ""
    classes += "today" if date == Date.today
    classes += " weekend" if date.is_weekend?
    classes += " other_month" if date.month != current_month
    classes
  end
end
