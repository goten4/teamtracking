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
  
  def self.report_for(team, options = {})
    sql_statement = "SELECT c.name AS company_name, o.title AS job_title, j.rate, SUM(a.am+a.pm) AS attendances_days_count FROM attendances AS a, users AS u, jobs AS j, occupations as o, companies AS c, assignments AS ut, teams AS t WHERE a.user_id = u.id AND u.job_id = j.id AND j.occupation_id = o.id AND j.company_id = c.id AND u.id = ut.user_id AND ut.team_id = t.id AND t.id = ?"
    sql_parameters = [ team.id ]
    unless sti_name == "Attendance"
      sql_statement += " AND a.#{inheritance_column} = ?"
      sql_parameters << sti_name
    end
    if options.key? :company
      sql_statement += " AND c.id = ?"
      sql_parameters << options[:company]
    end
    if options.key? :from
      sql_statement += " AND a.day >= ?"
      sql_parameters << options[:from]
    end
    if options.key? :to
      sql_statement += " AND a.day <= ?"
      sql_parameters << options[:to]
    end
    sql_statement += " GROUP BY c.id, o.id"
    find_by_sql [ sql_statement ].concat(sql_parameters)
  end
end
