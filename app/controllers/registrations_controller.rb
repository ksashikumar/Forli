class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_action

  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        render(status: 200, json: resource, serializer: UserSerializer, root: 'user')
      else
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render_errors(resource)
    end
  end
end