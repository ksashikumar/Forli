class CreateUserCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :user_categories do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :role
      t.timestamps
    end
    add_index :user_categories, :user_id
    add_index :user_categories, :category_id
  end
end
