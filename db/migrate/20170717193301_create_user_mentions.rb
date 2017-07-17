class CreateUserMentions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_mentions do |t|
      t.integer :user_id
      t.integer :mentionable_id
      t.string :mentionable_type
      t.timestamps
    end
    add_index :user_mentions, :user_id
    add_index :user_mentions, :mentionable_id
    add_index :user_mentions, :mentionable_type
  end
end
