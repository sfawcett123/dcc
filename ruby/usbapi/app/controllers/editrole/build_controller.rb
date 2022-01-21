# frozen_string_literal: true

module Editrole
  class BuildController < ApplicationController
    include Wicked::Wizard
    before_action :set_role, only: %i[show update]
    steps(*Role.form_steps)

    def show
      case step
      when :name_role
        logger.info 'ROLE'
      when :sketch_source
        logger.info 'SOURCE'
      end
      render_wizard
    end

    def update
      @role.update(roles_params(step))
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

    def roles_params(step)
      permitted_attributes = [:name]
      params.require(:role).permit(permitted_attributes).merge(form_step: step)
    end
  end
end
