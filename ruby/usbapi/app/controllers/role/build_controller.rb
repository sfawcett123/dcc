class Role::BuildController < ApplicationController
  include Wicked::Wizard

  before_action :set_role, only: %i[show update ]

  steps :name_role, :sketch_source

  def show
     case step
     when :name_role
        logger.info "ROLE"
     when :sketch_source
         logger.info "SOURCE"
     end
     render_wizard 
  end

  def update
     logger.info "Update #{params[:role_id]}"
     @role.update( :name => params[:name])
     render_wizard @role 
  end

  def finish_wizard_path
    roles_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:role_id])
  end
end
