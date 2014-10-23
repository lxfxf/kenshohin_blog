class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
    add_index :blogs, :created_at
  end
end
