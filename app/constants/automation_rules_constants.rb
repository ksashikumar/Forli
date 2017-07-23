module AutomationRulesConstants
  CREATE_FIELDS = [:name, :description, :match_all, :when, filter_data: [], action_data: []].freeze
  UPDATE_FIELDS = [:name, :description, :match_all, :when, :active, filter_data: [], action_data: []].freeze
  SHOW_FIELDS   = [].freeze
  INDEX_FIELDS  = [].freeze

  WHEN_TYPES = [
    :discussion_create,
    :discussion_update,
    :answer_create,
    :reply_create,
    :every_day
  ].freeze

  OPERATORS = [
    :is,
    :is_not,
    :contains,
    :starts_with,
    :ends_with,
    :gt_than,
    :ls_than
  ].freeze

  FILTER_TYPES = [
    :category,
    :tags,
    :upvotes,
    :downvotes,
    :follow_count,
    :spam_count,
    :discussion_title,
    :discussion_description,
    :answer_content,
    :reply_content
  ].freeze

  ACTION_TYPES = [
    :spam,
    :delete,
    :add_tag,
    :set_category,
    :send_email,
    :add_answer
  ].freeze

end.freeze