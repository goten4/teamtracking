class Attendance < ActiveRecord::Base
  belongs_to :user

  def self.calendar_for(user, date)
    from  = date.at_beginning_of_month.at_beginning_of_week
    to    = date.at_end_of_month.at_end_of_week
    attendances = find_all_by_user_id(user, :conditions => [ "day between ? and ?", from, to ])
    attendances_of_month = (from..to).map do |day|
      attendances.find { |attendance| attendance.day == day } || self.new(:user_id => user.id, :day => day)
    end
    attendances_of_month.in_groups_of(7)
  end
end
