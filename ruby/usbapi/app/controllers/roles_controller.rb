# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_role, only: [:show]
  before_action :set_title, only_member_actions: true

  def index
    @roles = ::Role.all
  end

  def set_title
    @page_title = 'ROLES'
  end

  def create
    @role = Role.new
    @role.save( validate: false )
    redirect_to role_build_path(@role, Role.form_steps.first)
  end

  def show
    redirect_to role_build_path(@role, Role.form_steps.first)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name, :path)
  end
end
