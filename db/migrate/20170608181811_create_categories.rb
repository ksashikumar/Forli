class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, limit: 30, null: false
      t.text :description
      t.integer :visibility, default: 0
      t.integer :level, default: 0
      t.integer :parent_id, null: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :categories, :parent_id
    add_index :categories, :name, unique: true
    add_index :categories, :visibility
  end
end
