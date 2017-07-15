module CommentConstants
  COMMENTABLE_HASH_FIELDS = %w(id type).freeze
  CREATE_FIELDS = [:content, :parent_id, :user_id, { commentable: COMMENTABLE_HASH_FIELDS }].freeze
  UPDATE_FIELDS = [:content, :user_id].freeze
  SHOW_FIELDS   = [:include].freeze
  INDEX_FIELDS  = [].freeze
end.freeze