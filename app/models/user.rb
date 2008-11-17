require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :permissions
  has_many :roles, :through => :permissions
  has_many :assignments
  has_many :teams, :through => :assignments
  belongs_to :company
  has_many :attendances
  
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :company_id
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :company_id
  attr_accessor :old_password


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def self.find_all_by_teams_and_company(teams, company)
    all :joins => :assignments, :conditions => ["company_id = ? AND team_id IN (?)", company, teams], :group => "users.id"
  end
  
  def self.find_by_id_and_teams_and_company(id, teams, company)
    find id, :joins => :assignments, :conditions => ["company_id = ? AND team_id IN (?)", company, teams]
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def company_name
    @company_name ||= self.company.name
  end

  def has_role?(name)
    self.roles.find_by_name(name) ? true : false
  end

  def has_team?(name)
    self.teams.find_by_name(name) ? true : false
  end

  def has_stats_permissions?
    ( self.has_role?('team_leader') && self.has_at_least_one_team? ) || self.has_role?('stats_reader') || self.has_role?('administrator')
  end

  def has_at_least_one_team?
    self.teams.size > 0
  end
end
