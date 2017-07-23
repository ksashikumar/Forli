class Answer < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :discussion
  belongs_to :user
  has_many :replies

  after_create :increment_answer_count

  after_destroy :decrement_answer_count

  after_commit :perform_spam_check, on: :create #, :if => :spam_filter_enabled?

  NOTIFIABLE_TYPE = 'answer'

  def get_notifiable_type
    NOTIFIABLE_TYPE
  end

  def view_count
    MetaInfo::ViewCount.new(viewable_id: self.id, viewable_type: 'answer').count
  end

  def increment_answer_count
    Reports::Data.update_unanswered_count(false) if (self.discussion.answers_count == 0)
    Discussion.update_counters(discussion_id, answers_count: 1)
  end

  def decrement_answer_count
    Reports::Data.update_unanswered_count(true) if (self.discussion.answers_count == 1)
    Discussion.update_counters(discussion_id, answers_count: -1)
  end

end
