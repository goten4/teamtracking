class Sprint < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team_id
  validates_presence_of :name
  validates_presence_of :starts_on
  validates_presence_of :ends_on
  
  def starts_on_formatted
    self.starts_on.strftime ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:european] unless self.starts_on.blank?
  end
  
  def starts_on_formatted=(value)
    self.starts_on = value.to_utc(:european)
  end
  
  def ends_on_formatted
    self.ends_on.strftime ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:european] unless self.ends_on.blank?
  end
  
  def ends_on_formatted=(value)
    self.ends_on = value.to_utc(:european)
  end
end
