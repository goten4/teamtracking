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
    from  = at_beginning_of_month.at_beginning_of_week
    to    = at_end_of_month.at_end_of_week
    weeks = (from..to).to_a.in_groups_of 7
  end
end
