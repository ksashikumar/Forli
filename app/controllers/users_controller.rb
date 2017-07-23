class UsersController < ApplicationController

  befor_action :admin?, only: [:index]

  def index
    render_items
  end

  def show
    render_item
  end

  def autocomplete
    @items = User.name_like(params[:term]).page(1).per(10)
    render_items
  end

  protected

  def load_objects
    @items = User.page(params[:page] || 1).per(10)
  end

  def load_object
    @item = User.find_by_id(params[:id])
    render_404 unless @item
  end

end