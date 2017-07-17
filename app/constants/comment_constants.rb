module CommentConstants
  CREATE_FIELDS = [:content, :parent_id, :user_id, :post_id, :discussion_id].freeze
  UPDATE_FIELDS = [:content, :user_id].freeze
  SHOW_FIELDS   = [:post_id, :discussion_id].freeze
  INDEX_FIELDS  = [:post_id, :discussion_id].freeze
end.freeze