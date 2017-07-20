class Post < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :discussion
  belongs_to :user
  has_many :comments, as: :commentable

  after_create :update_post_count

  after_commit :perform_spam_check, on: :create #, :if => :spam_filter_enabled?

  NOTIFIABLE_TYPE = 'post'

  def get_notifiable_type
    NOTIFIABLE_TYPE
  end

  def update_post_count
    Discussion.update_counters(discussion.id, posts_count: 1)
  end

end
