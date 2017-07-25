class SpamFilter::SpamCheckJob < ApplicationJob
  queue_as :spam_check

  def perform(options)
    spammable_hash = options.extract!(:spammable_id, :spammable_type)
    spammable_id   = spammable_hash[:spammable_id]
    spammable_type = spammable_hash[:spammable_type]

    spammable = Object.const_get(spammable_type).find_by_id(spammable_id)

    options[:key] = Akismet::KEY
    options[:comment_content] = spammable.content
    options[:comment_author]  = spammable.user.name,
    options[:comment_author_email] = spammable.user.email

    if SpamFilter::AkismetClient.spam?(options)
      Reports::Data.update_spammed_count(true) if spammable.is_a?(Discussion) && spammable.spam
      spammable.update_column(:spam, true)
      spammable.reindex
      discussion = spammable_type == 'Discussion' ? spammable : spammable.discussion
      notification_content = format(NotificationConstants::SPAM_MESSAGE_STRING, type: spammable_type)
      Notification::NotificationService.push_notification(discussion, notification_content, [spammable.user_id])
    end
  rescue Exception => e
    Rails.logger.error("Exception in spam_check: #{e.inspect}")
  end
end
