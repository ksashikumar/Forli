module DiscussionConstants
  CREATE_FIELDS = [:title, :description, :user_id, :category_id, tags: [], mentions: []].freeze
  UPDATE_FIELDS = [:title, :description, :category_id, tags: [], mentions: []].freeze
  SHOW_FIELDS   = [].freeze
  INDEX_FIELDS  = [].freeze
end.freeze