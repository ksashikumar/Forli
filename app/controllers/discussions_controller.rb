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
    assign_tags
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
    render_404 unless @item
  end

  def load_objects
    @items = Discussion.preload([:user, :posts, :tags, :category]).page(params[:page] || 1).per(params[:limit] || 10)
  end

  def build_object
    @tags = cname_params.extract!(:tags)[:tags]
    @item = Discussion.new(cname_params)
    assign_tags
  end

  def assign_tags
    if @tags
      @tags.each do |tag_str|
        tag = Tag.find_or_create_by(name: tag_str)
        @item.tags << tag
      end
    end
  end

  def allowed_params
    "DiscussionConstants::#{action_name.upcase}_FIELDS".constantize
  end
end