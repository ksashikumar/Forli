class Answer < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :discussion
  belongs_to :user
  has_many :replies

  after_create :increment_answer_count

  after_destroy :decrement_answer_count

  after_commit :perform_spam_check, on: :create # , :if => :spam_filter_enabled?
  after_commit :push_notification

  NOTIFIABLE_TYPE = 'answer'.freeze

  def get_notifiable_type
    NOTIFIABLE_TYPE
  end

  def view_count
    MetaInfo::ViewCount.new(viewable_id: id, viewable_type: 'answer').count
  end

  def increment_answer_count
    Reports::Data.update_unanswered_count(false) if discussion.answers_count == 0
    Discussion.update_counters(discussion_id, answers_count: 1)
  end

  def decrement_answer_count
    Reports::Data.update_unanswered_count(true) if discussion.answers_count == 1
    Discussion.update_counters(discussion_id, answers_count: -1)
  end

  def push_notification
    if user_id != discussion.user_id
      content = format(NotificationConstants::ANSWER_ADDED_STRING, user_name: user.name, discussion_title: discussion.title.truncate(10))
      Notification::NotificationService.push_notification_to(self, discussion, content, [discussion.user_id])
    end
  end
end
