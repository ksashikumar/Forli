class NotificationSerializer < BaseSerializer
  attributes :content, :notify_to, :notifiable_type, :discussion_id
  
end