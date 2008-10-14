class InsertRoles < ActiveRecord::Migration
  def self.up
    Role.create( :title => 'admin' )
    Role.create( :title => 'team_leader' )
    Role.create( :title => 'team_member' )
    Role.create( :title => 'stat_viewer' )
  end
  
  def self.down
    Role.delete_all
  end
end