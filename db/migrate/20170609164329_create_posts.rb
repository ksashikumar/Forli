class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.references :user, index: true, foreign_key: true
      t.references :discussion, index: true, foreign_key: true
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.integer :comments_count, default: 0      
      t.integer :views, default: 0
      t.float :score, default: 0
      t.boolean :deleted, default: false
      t.boolean :spam, default: false

      t.timestamps
    end
    add_index :posts, :score
    add_index :posts, :deleted
    add_index :posts, :spam
  end
end
