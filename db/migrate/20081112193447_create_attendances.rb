class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer :user_id
      t.date :day
      t.float :am, :precision => 2, :scale => 1, :default => 0
      t.float :pm, :precision => 2, :scale => 1, :default => 0 
      t.string :type

      t.timestamps
    end
    add_index :attendances, [ :user_id, :day, :type ], { :name => :user_day_type_index, :unique => true }
  end

  def self.down
    remove_index :attendances, :name => :user_day_type_index
    drop_table :attendances
  end
end
