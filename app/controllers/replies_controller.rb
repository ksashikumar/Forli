class RepliesController < ApplicationController

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

  def load_answer
    @answer = if cname_params[:answer_id]
      Answer.find_by_id(cname_params[:answer_id])
    else
      render_400(:answer_id, 'Missing param')
    end
  end

  def load_object
    load_answer
    @item = Reply.find_by_id(params[:id])
    render_404 unless @item
  end

  def load_objects
    load_answer
    @items = Reply.preload(:user).where(answer: @answer).page(params[:page] || 1).per(params[:limit] || 10)
  end

  def build_object
    load_answer
    @item = Reply.new(cname_params)
    @item.answer = @answer
  end

  def allowed_params
    "ReplyConstants::#{action_name.upcase}_FIELDS".constantize
  end
end
