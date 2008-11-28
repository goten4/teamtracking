class ReportingService

  def self.financial_report(team, start_date, end_date)
    if Date.today < start_date
    elsif Date.today > end_date
    else
    end
  end
end
