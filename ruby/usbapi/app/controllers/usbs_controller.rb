# frozen_string_literal: true

class UsbsController < ApplicationController
  before_action :set_usb, only: %i[show update ]
  before_action :set_title, only_member_actions: true

  # GET /usbs or /usbs.json
  def index
    @usbs = Usb.arduinos
  end

  # PATCH/PUT /usbs/1 or /usbs/1.json
  def update
    respond_to do |format|
      if @usb.update(usb_params)
        format.html { redirect_to usb_url(@usb), notice: 'Usb was successfully updated.' }
        format.json { render :show, status: :ok, location: @usb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usb.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_title
     @page_title = "USB Devices"
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
