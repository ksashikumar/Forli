class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, limit: 30, null: false
      t.text :description
      t.string :ancestry
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :categories, :name, unique: true
    add_index :categories, :ancestry
  end
end
