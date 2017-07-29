class SettingsController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :update]

  def index
    render_items
  end

  def show
    render_item
  end

  def update
    if @item.update_attributes(cname_params)
      render_item
    else
      render_errors(@item)
    end
  end

  def destroy
    if @item.destroy
      head 204
    else
      render_errors(@item)
    end
  end

  protected

  def load_object
    @item = AdminSetting.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @items = AdminSetting.all
  end

  def build_object
    @item = AdminSetting.new(cname_params)
  end

  def allowed_params
    "SettingsConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
