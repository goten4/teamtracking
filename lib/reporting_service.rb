class ReportingService
  
  def self.financial_report(team, company, start_date, end_date)
    if Date.today < start_date
      ExpectedAttendance.sum('am + pm', :conditions => [ 'day BETWEEN ? AND ? AND team_id = ? AND company_id = ?', start_date, end_date, team.id, company.id], :include => [ :user, :job ])
    elsif Date.today > end_date
    else
    end
  end
end
