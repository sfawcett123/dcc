# frozen_string_literal: true

class UsbsController < ApplicationController
  before_action :set_usb, only: %i[toggle]
  before_action :set_title, only_member_actions: true

  # GET /usbs or /usbs.json
  def index
    @usbs = Usb.arduinos
  end

  def toggle
    logger.info 'Toggle Action Selected'
    @usb.connected = !@usb.connected
    @usb.save
    ReadArduinoJob.perform_later @usb if @usb.connected
    redirect_to usbs_path
  end

  private

  def set_title
    @page_title = 'USB Devices'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_usb
    @usb = Usb.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def usb_params
    params.require(:usb).permit(:label, :address, :serialnumber)
  end
end
