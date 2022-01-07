# frozen_string_literal: true

class UsbsController < ApplicationController
  # GET /usbs
  def list
    @usbs = Usb.all

    render json: @usbs
  end
end
