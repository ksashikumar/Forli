class TagFiltersController < ApplicationController
  before_action :authenticate_action

  def create
    @item.user = current_user if cname_params[:user_id].nil?
    if @item.save
      render_item
    else
      render_errors(@item)
    end
  end

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
    @item = current_user.tag_filters.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @items = current_user.tag_filters.page(params[:page] || 1).per(params[:limit] || 10)
  end

  def build_object
    @item = current_user.tag_filters.new(cname_params)
  end

  def allowed_params
    "TagFilterConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
