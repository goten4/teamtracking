class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer :team_id
      t.string :name
      t.date :starts_at
      t.date :ends_at

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
