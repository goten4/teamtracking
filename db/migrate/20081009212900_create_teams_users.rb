class CreateTeamsUsers < ActiveRecord::Migration
  def self.up
    create_table :teams_users, :id => false do |t|
      t.integer :user_id, :team_id
    end
  end
  
  def self.down
    drop_table :teams_users
  end
end
