class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, limit: 30, null: false
      t.text :description
      t.integer :parent_id, null: true
      t.integer :child_count, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :categories, :parent_id
    add_index :categories, :name, unique: true
  end
end
