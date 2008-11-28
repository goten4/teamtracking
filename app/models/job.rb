class Job < ActiveRecord::Base
  has_many :users
  belongs_to :occupation
  belongs_to :company

  validates_presence_of :company_id
  validates_presence_of :occupation_id
  validates_presence_of :rate

  def company_name_and_title
    "#{self.company.name} / #{self.occupation.title}"
  end
end
