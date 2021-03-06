# frozen_string_literal: true

module RolesHelper
  EDIT_ICON = "<i class='fa fa-cog'></i>"
  DELETE_ICON = "<i class='fa fa-trash'></i>"

  def editicon
    EDIT_ICON.html_safe
  end

  def deleteicon
    DELETE_ICON.html_safe
  end
end
