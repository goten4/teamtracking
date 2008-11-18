class Sprint < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team_id
  validates_presence_of :name
  validates_presence_of :starts_at
  validates_presence_of :ends_at
  
  def starts_at_formatted
    self.starts_at.strftime ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:european] unless self.starts_at.blank?
  end
  
  def starts_at_formatted=(value)
    self.starts_at = value.to_utc(:european)
  end
  
  def ends_at_formatted
    self.ends_at.strftime ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:european] unless self.ends_at.blank?
  end
  
  def ends_at_formatted=(value)
    self.ends_at = value.to_utc(:european)
  end
end
