class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
    	t.string :first_name, :limit => 25
    	t.string :last_name, :limit => 50
    	t.string :email, :limit => 100
    	t.string :username, :limit => 25
    	t.string :hashed_password  

      t.timestamps null: false
    end
    add_index "admin_users", ["username"], :name => "username"
  end
end
