class BootstrapController < ApplicationController

  skip_before_action :load_objects

  def index
    item = { userSignedIn: user_signed_in? }
    render(json: item, status: 200, root: cname)
  end
end