class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.string :ancestry
      t.references :user, index: true, foreign_key: true
      t.integer :commentable_id
      t.string  :commentable_type

      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
    add_index :comments, :ancestry
  end
end
