class CreateDiscussionTags < ActiveRecord::Migration[5.1]
  def change
    create_table :discussion_tags do |t|
      t.integer :discussion_id
      t.integer :tag_id
      t.timestamps
    end
    add_index :discussion_tags, :discussion_id
    add_index :discussion_tags, :tag_id
    add_index :discussion_tags, [:discussion_id, :tag_id], unique: true
  end
end
