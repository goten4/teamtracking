class Team < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  has_many :sprints
end
