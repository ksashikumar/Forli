class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  after_commit :send_notification

  private

    def send_notification
      Notification::NotificationJob.perform_later(self.notification.id, self.id)
    end
end
