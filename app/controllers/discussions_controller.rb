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
    MetaInfo::ViewCount.new(view_count_hash).hit!
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
    validate_filters
    load_tag_filter if cname_params[:filter_id]
    condition = where_condition
    @items = if condition.present?
               Discussion.preload(DiscussionConstants::DISCUSSION_PRELOAD)
                         .where(condition).order('created_at desc').page(params[:page] || 1)
                         .per(params[:limit] || 10)
             else
               Discussion.preload(DiscussionConstants::DISCUSSION_PRELOAD)
                         .order('created_at desc').page(params[:page] || 1)
                         .per(params[:limit] || 10)
             end
  end

  def build_object
    tag_params = cname_params.extract!(:tags)[:tags] if cname_params[:tags]
    @item = Discussion.new(cname_params)
    assign_tags(tag_params)
  end

  def validate_filters
    render_403 if cname_params[:filter_id] && current_user.nil?
    render_400(:tag_ids, 'Not allowed') if cname_params[:filter_id] && cname_params[:tag_ids]
    render_400(:filter, 'Not allowed') if cname_params[:filter_id] && cname_params[:filter]
  end

  def assign_tags(tag_params)
    return unless tag_params
    item_tags = @item.tags.map(&:name)
    tags_to_remove = item_tags - tag_params
    tags_to_add = tag_params - item_tags
    @item.add_tags(tags_to_add)
    @item.remove_tags(tags_to_remove)
  end

  def load_tag_filter
    filter_id = cname_params.extract!(:filter_id)[:filter_id] if cname_params[:filter_id]
    @tag_filter = current_user.tag_filters.find_by_id(filter_id)
    render_404 unless @tag_filter
  end

  def where_condition
    tag_ids   = cname_params.extract!(:tag_ids)[:tag_ids] if cname_params[:tag_ids]
    filter    = cname_params.extract!(:filter)[:filter] if cname_params[:filter]
    condition = []
    if @tag_filter
      discussion_ids = DiscussionTag.select(:discussion_id).where('tag_id IN (?)', @tag_filter.tag_ids).map(&:discussion_id)
      condition = ['id IN (?)', discussion_ids]
    end
    if tag_ids
      discussion_ids = DiscussionTag.select(:discussion_id).where('tag_id IN (?)', tag_ids.split(',')).map(&:discussion_id)
      condition = ['id IN (?)', discussion_ids]
    end
    if filter && DiscussionConstants::FILTERS.include?(filter.to_sym)
      filter_condition = filter_condition(filter)
      if filter_condition.present?
        if condition.present?
          cond = condition[0] + ' AND ' + filter_condition
          condition[0] = cond
        else
          condition << filter_condition
        end
      end
    end
    condition
  end

  def filter_condition(filter)
    case filter.to_sym
    when :trending
      avg_views = Discussion.average(:views) # Need to find optimized way!
      "created_at > '#{5.days.ago}' AND views > #{avg_views}"
    when :latest
    when :featured
    when :unanswered
      'answers_count = 0'
    end
  end

  def allowed_params
    "DiscussionConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
