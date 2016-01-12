class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
    	t.references :page     # This adds the foreign key id from pages
    	# t.integer "page_id"     Same code as above
    	t.string :name
    	t.integer :position
    	t.boolean :visible, :default => false
    	t.string :content_type
    	t.text :content

      t.timestamps null: false
    end
    add_index("sections", "page_id")
  end
end
