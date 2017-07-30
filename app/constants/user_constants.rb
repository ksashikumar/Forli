module UserConstants
  PREFERENCES   = [:email_notification, :allow_tagging].freeze
  UPDATE_FIELDS = [:image, preferences: PREFERENCES].freeze
  SHOW_FIELDS   = [].freeze
  INDEX_FIELDS  = [].freeze
end.freeze
