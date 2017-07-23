class DiscussionsController < ApplicationController
  include Concerns::DiscussionAnswer
  # before_action :authenticate_user!, only: [:create, :update]

  def create
    assign_akismet_params
    @item.user = current_user if cname_params[:user_id].nil?
    @item.published = true # Manually doing it for now. Once we do admin_setting, this will be configurable
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
    tag_params = cname_params.extract!(:tags)[:tags] if cname_params[:tags]
    assign_tags(tag_params)
    if @item.update_attributes(cname_params)
      render_item
    else
      render_errors(@item)
    end
  end

  def destroy
    if @item.update_attributes(delted: true)
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
    tag_ids = cname_params.extract!(:tag_ids)[:tag_ids] if cname_params[:tag_ids]
    filter  = cname_params.extract!(:filter)[:filter] if cname_params[:filter]
    if(tag_ids)
      discussion_ids = DiscussionTag.select(:discussion_id).where('tag_id IN (?)', tag_ids.split(',')).map(&:discussion_id)
      @items = Discussion.preload(DiscussionConstants::DISCUSSION_PRELOAD).where('id IN (?)', discussion_ids).page(params[:page] || 1).per(params[:limit] || 10)
    else
      @items = Discussion.preload(DiscussionConstants::DISCUSSION_PRELOAD).page(params[:page] || 1).per(params[:limit] || 10)
    end
  end

  def build_object
    tag_params = cname_params.extract!(:tags)[:tags] if cname_params[:tags]
    @item = Discussion.new(cname_params)
    assign_tags(tag_params)
  end

  def assign_tags(tag_params)
    if tag_params
      item_tags = @item.tags.map(&:name)
      tags_to_remove = item_tags - tag_params
      tags_to_add = tag_params - item_tags
      @item.add_tags(tags_to_add)
      @item.remove_tags(tags_to_remove)
    end
  end

  def allowed_params
    "DiscussionConstants::#{action_name.upcase}_FIELDS".constantize
  end
end