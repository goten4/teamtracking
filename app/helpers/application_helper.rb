module ApplicationHelper
  def calendar_classes_of(date, current_month)
    classes = ""
    classes += "today" if date == Date.today
    classes += " weekend" if date.is_weekend?
    classes += " other_month" if date.month != current_month
    classes
  end

  def morning_id_of(date)
    "'am#{date.to_s(:number)}'"
  end

  def afternoon_id_of(date)
    "'pm#{date.to_s(:number)}'"
  end

  def ids_of_day(date)
    "$A([#{morning_id_of(date)}, #{afternoon_id_of(date)}])"
  end

  def ids_of_week(week)
    result = "$A(["
    week.each { |date| result += "#{morning_id_of(date)},#{afternoon_id_of(date)}," }
    result[result.length-1] = "]"
    result + ")"
  end
end
