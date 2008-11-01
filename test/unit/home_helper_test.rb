require 'test_helper'

class HomeHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include HomeHelper
  
  def test_calendar_classes_of_should_render_empty_class
    classes = calendar_classes_of("2008-11-4".to_date, 11)
    assert_not_nil classes
    assert_equal "", classes, "class should be empty"
  end
  
  def test_calendar_classes_of_should_render_today_class_when_today
    classes = calendar_classes_of(Date.today, Date.today.month)
    assert_not_nil classes
    assert classes.include?("today"), "class today should be there"
  end
  
  def test_calendar_classes_of_should_render_weekend_class_when_weekend
    classes = calendar_classes_of(Date.today.at_end_of_week, Date.today.month)
    assert_not_nil classes
    assert classes.include?("weekend"), "class weekend should be there"
  end
  
  def test_calendar_classes_of_should_render_other_month_class_when_other_month
    classes = calendar_classes_of("2008-11-1".to_date, 12)
    assert_not_nil classes
    assert classes.include?("other_month"), "class other_month should be there"
  end
end