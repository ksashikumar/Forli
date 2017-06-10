class CategoriesController < ApplicationController

  def create
    category_service = CategoryService.new(current_user, params)
    category = category_service.perform_create
    render json: category
  end

  def index
  end

  def show
  end

  def update
  end

  def destroy
  end

end
