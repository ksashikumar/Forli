class AddTagDiscussionIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :discussion_tags, [:tag_id, :discussion_id]
  end
end
