class Roles::BuildController < Wicked::WizardController
  steps :add_name, :add_source

  def show
    @role = Role.find(params[:role_id])
    render_wizard
  end

  def update
    @role = Role.find(params[:role_id])
    @role.update_attributes(params[:role])
    render_wizard @role
  end

  def create
    @role = Role.create
    redirect_to wizard_path(steps.first, role_id: @role.id)
  end
end
