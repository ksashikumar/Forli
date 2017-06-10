class CategoryService
  include CategoryConstants

  def initialize(user, params)
    @user   = user
    @params = params
  end

  def perform_create
  end

  def perform_update
  end

  def perform_delete
  end

  private

  def allowed_params
    "CategoryConstants::#{action_name.upcase}_FIELDS".constantize
  end

  def action_name
    @params[:action].to_sym
  end
end
