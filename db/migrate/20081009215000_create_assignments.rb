class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :team_id, :user_id, :null => false
      t.integer :updated_by
      t.timestamps
    end
  end
  
  def self.down
    drop_table :assignments
  end
end
