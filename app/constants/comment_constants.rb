module CommentConstants
  COMMENTABLE_HASH_FIELDS = %w(id type).freeze
  UPDATE_FIELDS = [:content, :parent_id, :user_id, { commentable: COMMENTABLE_HASH_FIELDS }].freeze
  UPDATE_FIELDS = [:content, :parent_id, :user_id].freeze
end.freeze
