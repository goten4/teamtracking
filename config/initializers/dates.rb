require 'date'

class Date
  def is_weekend?
    self.wday == 6 || self.wday == 0
  end

  def is_weekday?
    !self.is_weekend?
  end
  
  def week_number
    self.strftime("%W").to_i % 52 + 1
  end
  
  def week
    Array.new(7) { |offset| self.at_beginning_of_week + offset.days }
  end
  
  def weeks_of_month
    weeks = Array.new
    next_month = (self + 1.month).month
    current_day = self.at_beginning_of_month.at_beginning_of_week
    while current_day.month != next_month
      weeks << current_day.week
      current_day += 7.days
    end
    weeks
  end
end
