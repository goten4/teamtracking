class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :role_id, :user_id, :null => false
      t.integer :updated_by
      t.timestamps
    end
    
    # Make sure the role migration file was generated first
    Role.create({
      :name => 'administrator'
    })
    Role.create({
      :name => 'stats_reader'
    })
    Role.create({
      :name => 'team_leader'
    })
    # Make sure the companies migration file was generated first
    olm = Company.create({
      :name => 'Orange Business Services online multimedia'
    })
    # Add the default admin user
    # Be sure to change the password
    user = User.new({
      :login => 'admin',
      :name => 'Administrateur',
      :email => 'admin@cvf.fr',
      :password => '4dm1n',
      :password_confirmation => '4dm1n',
      :company_id => olm
    })
    user.save(false)

    role = Role.find_by_name('administrator')

    permission = Permission.new
    permission.role = role
    permission.user = user
    permission.save(false)
  end

  def self.down
    drop_table :permissions
    Role.find_by_name('administrator').destroy
    Role.find_by_name('stats_reader').destroy
    Role.find_by_name('team_leader').destroy
    User.find_by_login('admin').destroy
  end
end

