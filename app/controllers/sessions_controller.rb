class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_action

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.tokens,
          email: user.email
        }
        render(json: data, status: 201) && return
      end
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end
