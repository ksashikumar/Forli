class NotificationsController < ApplicationController
  def index
    render_items
  end

  protected

  def load_objects
    @items = current_user.notifications.page(params[:page] || 1).per(5)
  end
end
