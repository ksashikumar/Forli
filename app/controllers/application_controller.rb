class ApplicationController < ActionController::API
  def current_user
    # hack for now.
    User.new
  end
end
