class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :blog, index: true

      t.timestamps
    end
  end
end
