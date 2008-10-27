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
    # Add the default admin user
    # Be sure to change the password
    user = User.new({
      :login => 'admin',
      :email => 'admin@cvf.fr',
      :password => '4dm1n',
      :password_confirmation => '4dm1n'
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
    User.find_by_login('admin').destroy
  end
end
