class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.text :content, null: false
      t.references :user, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true
      t.boolean :spam, default: false

      t.timestamps
    end
    add_index :replies, :spam
  end
end
