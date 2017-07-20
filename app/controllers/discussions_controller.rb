class DiscussionsController < ApplicationController
  include Concerns::DiscussionPost
  # before_action :authenticate_user!, only: [:create, :update]

  def create
    assign_akismet_params
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
    @item = Discussion.find_by_id(params[:id])
    assign_tags
    render_404 unless @item
  end

  def load_objects
    @items = Discussion.all
  end

  def build_object
    @item = Discussion.new(cname_params)
    assign_tags
  end

  def assign_tags
    if cname_params[:tags].present?
      cname_params.extract!(:tags)
      tags = Tag.where(cname_params[:tags])
      @item.tags = tags
    end
  end

  def allowed_params
    "DiscussionConstants::#{action_name.upcase}_FIELDS".constantize
  end
end