class CreateAdminUsersPagesJoin < ActiveRecord::Migration
  def change
    create_table :admin_users_pages, :id => false do |t|
    	t.integer "admin_user_id"		# This adds the foreign key id from admin_user
    	t.integer "page_id"     # This adds the foreign key id from page
    end
    add_index :admin_users_pages, ["admin_user_id", "page_id"]
  end
end
