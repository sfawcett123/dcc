# frozen_string_literal: true

module RolesHelper
  EDIT_ICON = "<i style='color: green;'class='fa fa-cog'></i>"

  def editicon
    EDIT_ICON.html_safe
  end

end
