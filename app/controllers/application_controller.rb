class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  # include ActionController::ImplicitRender
  # include ActionController::Helpers
  # include ActionController::Serialization
  # include ActionView::Layouts
  # include ActionController::Flash
  # include ActionController::Cookies
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # include ActionController::RequestForgeryProtection
  # protect_from_forgery with: :null_session

  # rescue_from StandardError, with: :render_500

  before_action :cname_params, only: [:create, :update]
  before_action :load_object,  only: [:show, :update, :delete]
  before_action :load_objects, only: :index
  before_action :build_object, only: :create

  def current_user
    # hack for now.
    User.first
  end

  def render_errors(item)
    # TODO: handle proper error response format
    render(json: item.errors, status: 400)
  end

  def render_404
    render(nothing: true, status: 404)
  end

  def render_500
    render(status: 500)
  end

  protected

  def cname_params
    params.require(controller_name.singularize).permit(*allowed_params)
  end

end
