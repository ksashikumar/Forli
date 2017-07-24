class Notification::NotificationService
  class << self
    def push_notification(discussion, content, user_ids)
      notification = discussion.notifications.build(
        content: content,
        user_ids: user_ids
      )
      notification.save
    end

    def push_notification_to(notifiable, discussion, content, user_ids)
      notification = discussion.notifications.build(
        content: content,
        user_ids: user_ids,
        notify_to: notifiable.id,
        notifiable_type: notifiable.get_notifiable_type
      )
      notification.save
    end
  end
end
