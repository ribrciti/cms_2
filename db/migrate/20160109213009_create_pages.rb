class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
    	t.references :subject     # This adds the foreign key id from subjects
    	# t.integer "subject_id"     Same code as above
    	t.string :name
    	t.string :permalink
    	t.integer :position
    	t.boolean :visible

      t.timestamps null: false
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end
  def down
  	drop_table :pages  # indexes above are on table and will drop
  end                  # if the table is dropped.
end
