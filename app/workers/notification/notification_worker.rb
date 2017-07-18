class Notification::NotificationWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :notification_worker, :retry => 0, :backtrace => true

  def perform(notification_id, user_id)
    notification = Notification.find notification_id
    notification_serializer = ActiveModelSerializers::SerializableResource.new notification
    ActionCable.server.broadcast "notifications:#{user_id}", notification_serializer.as_json
  end

end