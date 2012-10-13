class AddPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :encrypted_password, :string #add columns to the users table
  end
  
  def self.down
	  remove_column :users, :encrypted_password
  end
  
end
