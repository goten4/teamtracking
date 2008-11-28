class CreateOccupations < ActiveRecord::Migration
  def self.up
    create_table :occupations do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :occupations
  end
end
