class UsersController < ApplicationController
  # before_action :admin?, only: [:index]
  before_action :check_current_user, only: [:update]

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

  def autocomplete
    @items = User.name_like(params[:term]).page(1).per(10)
    render_items
  end

  def me
    @item = current_user
    render_item
  end

  protected

  def load_objects
    @items = User.page(params[:page] || 1).per(10)
  end

  def load_object
    @item = User.find_by_id(params[:id])
    render_404 unless @item
  end

  def allowed_params
    "UserConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
