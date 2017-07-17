class TagsController < ApplicationController

  # before_action :authenticate_user!, only: [:create, :update]

  def create
    if @item.save
      render(json: @item)
    else
      render_errors(@item)
    end
  end

  def index
    render(json: @items)
  end

  def show
    render(json: @item)
  end

  def update
    if @item.update_attributes(cname_params)
      render(json: @item)
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
    @item = Tag.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @items = Tag.all
  end

  def build_object
    @item = Tag.new(cname_params)
  end

  def allowed_params
    "TagConstants::#{action_name.upcase}_FIELDS".constantize
  end

end