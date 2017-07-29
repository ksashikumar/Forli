class TagsController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :update]

  def create
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

  def autocomplete
    @items = Tag.name_like(params[:term]).page(1).per(10)
    render_items
  end

  protected

  def load_object
    @item = Tag.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @items = Tag.order('count desc').page(params[:page] || 1).per(params[:limit] || 10)
  end

  def build_object
    @item = Tag.new(cname_params)
  end

  def allowed_params
    "TagConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
