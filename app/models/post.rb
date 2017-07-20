class Post < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :discussion
  belongs_to :user
  has_many :comments, as: :commentable

  after_commit :perform_spam_check, on: :create #, :if => :spam_filter_enabled?

  NOTIFIABLE_TYPE = 'post'

  def get_notifiable_type
    NOTIFIABLE_TYPE
  end

end
