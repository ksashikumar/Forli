module DiscussionConstants
  CREATE_FIELDS = [:title, :description, :user_id, :category_id, tags: []].freeze
  UPDATE_FIELDS = [:title, :description, :user_id, :category_id, tags: []].freeze
  SHOW_FIELDS   = [].freeze
  INDEX_FIELDS  = [].freeze
end.freeze