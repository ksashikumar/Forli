class NotificationsController < ApplicationController
  skip_before_action :load_object

  def index
    render_items
  end

  def destroy
    user_notification = UserNotification.find(user_id: current_user.id, notification_id: params[:id])
    user_notification.destroy
    head 204
  end

  protected

  def load_objects
    @items = current_user.notifications.order('created_at desc').page(params[:page] || 1).per(5)
  end
end
