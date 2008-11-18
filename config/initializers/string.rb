class String
  def to_utc(format)
    Date.strptime(self, ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[format]).to_s(:utc)
  rescue
    self
  end
end