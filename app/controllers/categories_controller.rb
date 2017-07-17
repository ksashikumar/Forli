class CategoriesController < ApplicationController

  # before_action :authenticate_user!, only: [:create, :update]

  def create
    @item.user = current_user if cname_params[:user_id].nil?
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
    @item = Category.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    @items = Category.preload(:user).where(parent_id: nil)
  end

  def build_object
    @item = Category.new(cname_params)
    if cname_params[:parent_id]
      parent = Category.find_by_id(cname_params[:parent_id])
      render_404 unless parent
      @item.parent = parent
    end
  end

  def allowed_params
    "CategoryConstants::#{action_name.upcase}_FIELDS".constantize
  end

end
