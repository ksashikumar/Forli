module ReplyConstants
  CREATE_FIELDS = [:content, :user_id, :answer_id, mentions: []].freeze
  UPDATE_FIELDS = [:content, :answer_id, mentions: []].freeze
  SHOW_FIELDS   = [:answer_id].freeze
  INDEX_FIELDS  = [:answer_id].freeze
end.freeze