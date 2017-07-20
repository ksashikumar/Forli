class PostsController < ApplicationController
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
    @item = Post.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @parent = Discussion.find_by_id(params[:discussion_id])
    if @parent
      @items = @parent.posts.page(params[:page] || 1).per(params[:limit] || 10)
    else
      render_404
    end
  end

  def build_object
    @parent = Discussion.find_by_id(params[:discussion_id])
    if @parent
      @item = Post.new(cname_params)
      @item.discussion = @parent
    else
      render_404
    end
  end

  def allowed_params
    "PostConstants::#{action_name.upcase}_FIELDS".constantize
  end

end