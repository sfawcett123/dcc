class RolesController < ApplicationController

  # GET /roles
  def list
    @roles = Role.all
    render json: @roles
  end

end
