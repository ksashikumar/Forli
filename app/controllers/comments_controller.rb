class CommentsController < ApplicationController

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

  def children
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

  def load_commentable
    @commentable = if cname_params[:post_id]
      Post.find_by_id(cname_params[:post_id])
    else
      Discussion.find_by_id(cname_params[:discussion_id])
    end
    render_404 unless @commentable
  end

  def load_object
    @item = Comment.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    load_commentable
    @items = Comment.preload(:user).where(parent_id: nil, commentable: @commentable)
  end

  def build_object
    load_commentable
    @item = Comment.new(cname_params)
    @item.commentable = @commentable
    if cname_params[:parent_id]
      parent = Comment.find_by_id(cname_params[:parent_id])
      render_404 unless parent
      @item.parent = parent
    end
  end

  def allowed_params
    "CommentConstants::#{action_name.upcase}_FIELDS".constantize
  end

end