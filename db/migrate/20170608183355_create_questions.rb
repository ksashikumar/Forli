class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.references :user, index: true, foreign_key: true
      t.integer :upvote_count, default: 0
      t.integer :downvote_count, default: 0
      t.integer :answer_count, default: 0
      t.integer :follow_count, default: 0
      t.integer :views, default: 0
      t.float :score, default: 0
      t.boolean :deleted, default: false
      t.boolean :spam, default: false

      t.timestamps
    end
  end
end
