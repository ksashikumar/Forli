class Reply < ApplicationRecord
  include SpamFilter::Util

  attr_accessor :request_url, :remote_ip, :referrer, :user_agent

  belongs_to :user
  belongs_to :answer

  after_create :update_replies_count
  after_commit :perform_spam_check, on: :create # , :if => :spam_filter_enabled?

  def update_replies_count
    Answer.update_counters(answer_id, replies_count: 1)
  end
end
