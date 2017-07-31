class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_action

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if request.format.json?
      data = {
        token: resource.tokens,
        email: resource.email
      }
      render(json: data, status: 201)
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end
