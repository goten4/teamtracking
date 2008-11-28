class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :occupation_id
      t.integer :company_id
      t.float :rate, :precision => 6, :scale => 2, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
