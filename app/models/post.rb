class Post < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :discussion
  belongs_to :user
  has_many :comments, as: :commentable

  after_create :increment_post_count

  after_destroy :decrement_post_count

  after_commit :perform_spam_check, on: :create #, :if => :spam_filter_enabled?

  NOTIFIABLE_TYPE = 'post'

  def get_notifiable_type
    NOTIFIABLE_TYPE
  end

  def increment_post_count
    Reports::Data.update_unanswered_count(false) if (self.discussion.posts_count == 0)
    Discussion.update_counters(discussion_id, posts_count: 1)
  end

  def decrement_post_count
    Reports::Data.update_unanswered_count(true) if (self.discussion.posts_count == 1)
    Discussion.update_counters(discussion_id, posts_count: -1)
  end

end
