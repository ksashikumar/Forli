module DiscussionConstants
  CREATE_FIELDS      = [:title, :description, :user_id, tags: [], mentions: []].freeze
  UPDATE_FIELDS      = [:title, :description, tags: [], mentions: []].freeze
  SHOW_FIELDS        = [:id].freeze
  INDEX_FIELDS       = [:filter, :filter_id, :tag_ids, :page, :limit].freeze
  VIEW_FIELDS        = [:id].freeze
  UPVOTE_FIELDS      = [:id].freeze
  DOWNVOTE_FIELDS    = [:id].freeze
  ES_INDEX_COLUMNS   = [:id, :user_id, :title, :description, :tags, :sentiment, :locked,
                        :published, :spam, :deleted, :created_at, :updated_at].freeze
  DISCUSSION_PRELOAD = [:user, :answers, :tags].freeze
  FILTERS            = [:trending, :latest, :featured, :unanswered].freeze
end.freeze
