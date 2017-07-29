module AnswerConstants
  CREATE_FIELDS       = [:content, :discussion_id, :user_id, mentions: []].freeze
  UPDATE_FIELDS       = [:content, :discussion_id, :user_id, mentions: []].freeze
  SHOW_FIELDS         = [:id].freeze
  INDEX_FIELDS        = [:discussion_id].freeze
  VIEW_FIELDS         = [:id, :discussion_id].freeze
  UPVOTE_FIELDS       = [:id, :discussion_id].freeze
  DOWNVOTE_FIELDS     = [:id, :discussion_id].freeze
  MARK_CORRECT_FIELDS = [:id, :discussion_id].freeze
end.freeze
