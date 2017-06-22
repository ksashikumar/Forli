class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :level, default: 0
      t.integer :parent_id, null: true
      t.integer :child_count, default: 0
      t.references :user, index: true, foreign_key: true
      t.integer :commentable_id
      t.string  :commentable_type

      t.timestamps
    end
    add_index :comments, :parent_id
    add_index :comments, :child_count
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
