class CreateTagFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_filters do |t|
      t.string :name
      t.text :data
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
    add_index :tag_filters, [:name, :user_id], unique: true
  end
end
