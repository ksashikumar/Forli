class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :content, null: false
      t.references :user, index: true, foreign_key: true
      t.references :discussion, index: true, foreign_key: true
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.integer :replies_count, default: 0
      t.integer :views, default: 0
      t.float :score, default: 0
      t.boolean :deleted, default: false
      t.boolean :spam, default: false

      t.timestamps
    end
    add_index :answers, :score
    add_index :answers, :deleted
    add_index :answers, :spam
  end
end
