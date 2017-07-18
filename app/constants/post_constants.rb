module PostConstants
  CREATE_FIELDS = [:content, :discussion_id, :user_id, mentions: []].freeze
  UPDATE_FIELDS = [:content, :user_id, mentions: []].freeze
  SHOW_FIELDS   = [].freeze
  INDEX_FIELDS  = [].freeze
end.freeze