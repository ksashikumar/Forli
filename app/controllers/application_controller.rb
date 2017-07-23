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

  before_action :load_object,  only: [:show, :update, :delete, :upvote, :downvote, :view]
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

  def render_400(field, message)
    render(json: { field: field, message: message } , status: 400)
  end

  def render_item(root_key = cname)
    render(json: @item, status: 200, root: root_key)
  end

  def render_items(root_key = cname.pluralize)
    render(json: @items, status: 200, root: root_key, meta: count_meta_hash)
  end

  def render_201
    render(nothing: true, status: 201)
  end

  def render_500
    render(json: { message: 'Something went wrong in the server' }, status: 500)
  end

  def build_object
  end

  def load_object
  end

  protected

  def cname_params
    @cname_params ||= begin
      params[cname].present? ? params.require(cname).permit(*allowed_params) : params.permit(*allowed_params)
    end
  end

  def cname
    @cname ||= controller_name.singularize
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def count_meta_hash
    {
      count: @items.total_count
    }
  end

  def akismet_request_params
    {
      request_url: request.url,
      remote_ip: request.remote_ip,
      referrer: request.referrer,
      user_agent: request.env['HTTP_USER_AGENT']
    }
  end

  def assign_akismet_params
    akismet_request_params.each do |key, value|
      @item.send("#{key}=", value)
    end
  end

  def admin?
    current_user.admin?
  end

  def moderator?
    current_user.moderator?
  end
end
