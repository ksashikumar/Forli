class AnswersController < ApplicationController
  include Concerns::DiscussionAnswer
  # before_action :authenticate_user!, only: [:create, :update]

  def create
    assign_akismet_params
    @item.user = current_user if cname_params[:user_id].nil?
    if @item.save
      render_item(cname.pluralize)
    else
      render_errors(@item)
    end
  end

  def index
    render_items
  end

  def show
    MetaInfo::ViewCount.new(view_count_hash).hit!
    render_item(cname.pluralize)
  end

  def update
    if @item.update_attributes(cname_params)
      render_item(cname.pluralize)
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
    @item = Answer.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @discussion = Discussion.find_by_id(cname_params[:discussion_id])
    if @discussion
      @items = @discussion.answers.page(params[:page] || 1).per(params[:limit] || 10)
    else
      render_400(:discussion_id, 'Missing param')
    end
  end

  def build_object
    @discussion = Discussion.find_by_id(cname_params[:discussion_id])
    if @discussion
      @item = Answer.new(cname_params)
      @item.discussion = @discussion
    else
      render_400(:discussion_id, 'Missing param')
    end
  end

  def allowed_params
    "AnswerConstants::#{action_name.upcase}_FIELDS".constantize
  end

end