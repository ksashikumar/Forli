class CreateDiscussions < ActiveRecord::Migration[5.1]
  def change
    create_table :discussions do |t|
      t.text :title, null: false
      t.text :description, null: false
      t.references :user, index: true, foreign_key: true
      t.column :category_id, "bigint"
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.integer :posts_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :follows_count, default: 0
      t.integer :views, default: 0
      t.float :score, default: 0
      t.boolean :pinned, default: false
      t.boolean :locked, default: false
      t.boolean :published, default: false
      t.boolean :deleted, default: false
      t.boolean :spam, default: false

      t.timestamps
    end
    add_foreign_key :discussions, :categories
    add_index :discussions, :category_id
    add_index :discussions, :score
    add_index :discussions, :pinned
    add_index :discussions, :published
    add_index :discussions, :deleted
    add_index :discussions, :spam
  end
end
