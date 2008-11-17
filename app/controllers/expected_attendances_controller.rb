class ExpectedAttendancesController < AttendancesController

  def index
  end

  def update
    super
  end

protected

  def find_attendance_calendar
    @attendance_calendar = ExpectedAttendance.calendar_for @user, @date
  end
end
