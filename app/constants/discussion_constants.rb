module DiscussionConstants
  CREATE_FIELDS   = [:title, :description, :user_id, :category_id, tags: [], mentions: []].freeze
  UPDATE_FIELDS   = [:title, :description, :category_id, tags: [], mentions: []].freeze
  SHOW_FIELDS     = [:id].freeze
  INDEX_FIELDS    = [].freeze
  VIEW_FIELDS     = [:id].freeze
  UPVOTE_FIELDS   = [:id].freeze
  DOWNVOTE_FIELDS = [:id].freeze
end.freeze