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
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_errors(item, status=400)
    # TODO: handle proper error response format
    render(json: item.errors, status: 400)
  end

  def render_404
    render(nothing: true, status: 404)
  end

  def render_500
    render(status: 500)
  end

  def build_object
  end

  def load_object
  end

  protected

  def cname_params
    params[cname].present? && params.require(cname).permit(*allowed_params)
  end

  def cname
    @cname ||= controller_name.singularize
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

  def admin?
    current_user.admin?
  end

  def moderator?
    current_user.moderator?
  end
end
