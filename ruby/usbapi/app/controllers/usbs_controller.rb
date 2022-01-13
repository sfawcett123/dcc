# frozen_string_literal: true

class UsbsController < ApplicationController
  before_action :set_usb, only: %i[show edit update destroy]

  # GET /usbs or /usbs.json
  def index
    @usbs = Usb.all
  end

  # GET /usbs/1 or /usbs/1.json
  def show; end

  # GET /usbs/new
  def new
    @usb = Usb.new
  end

  # GET /usbs/1/edit
  def edit; end

  # POST /usbs or /usbs.json
  def create
    @usb = Usb.new(usb_params)

    respond_to do |format|
      if @usb.save
        format.html { redirect_to usb_url(@usb), notice: 'Usb was successfully created.' }
        format.json { render :show, status: :created, location: @usb }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usb.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /usbs/1 or /usbs/1.json
  def destroy
    @usb.destroy

    respond_to do |format|
      format.html { redirect_to usbs_url, notice: 'Usb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_usb
    @usb = Usb.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def usb_params
    params.require(:usb).permit(:label, :address, :serialnumber)
  end
end
