class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

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

  rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_params

  before_action :authenticate_action, only: %i[create update destroy me upvote downvote  mark_correct exists]

  before_action :load_object,  only: %i[show update destroy upvote downvote view mark_correct]
  before_action :load_objects, only: :index
  before_action :build_object, only: :create
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_errors(item, _status = 400)
    # TODO: handle proper error response format
    render(json: item.errors, status: 400)
  end

  def render_403
    render(nothing: true, status: 403)
  end

  def render_400(field, message)
    render(json: { field: field, message: message }, status: 400)
  end

  def render_404
    render(nothing: true, status: 404)
  end

  def render_unpermitted_params
    render(json: { message: "Unpermitted params found in request. Permitted params: #{allowed_params}" }, status: 400)
  end

  def render_unauthorized(realm = 'Application')
    headers['WWW-Authenticate'] = %(Token realm="#{realm.delete('"')}")
    render json: 'Bad credentials', status: :unauthorized
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

  def build_object; end

  def load_object; end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :image])
  end

  def authenticate_action
    authenticate_user_from_token || render_unauthorized
    authenticate_user!
  end

  def authenticate_user_from_token
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.tokens, token)
        sign_in user, store: false
      end
    end
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

  def check_current_user
    current_user && current_user.id == params[:id]
  end

  def admin?
    current_user.admin?
  end

  def moderator?
    current_user.moderator?
  end
end
