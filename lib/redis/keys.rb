module Redis::Keys
  USER_VOTE_HSET         = 'USER_VOTE_HSET:%{user_id}'.freeze
  DISCUSSION_VIEW_COUNT  = 'DISCUSSION_VIEW_COUNT:%{discussion_id}'.freeze
  ANSWER_VIEW_COUNT      = 'ANSWER_VIEW_COUNT:%{answer_id}'.freeze
  UNANSWERED_COUNT       = 'UNANSWERED_COUNT'.freeze
  SPAMMED_COUNT          = 'SPAMMED_COUNT'.freeze
  UNPUBLISHED_COUNT      = 'UNPUBLISHED_COUNT'.freeze
  AVG_SENTIMENT_SCORE    = 'AVG_SENTIMENT_SCORE'.freeze
end
