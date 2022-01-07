class ArduinosController < ApplicationController
  before_action :set_arduino, only: %i[ write read ]

  # GET /arduinos
  def list
    @arduinos = Arduino.all

    render json: @arduinos
  end

  # GET /arduinos/1
  def read
    render json: @arduino
  end

  # PATCH/PUT /arduinos/1
  def write
    if @arduino.update(arduino_params)
      render json: @arduino
    else
      render json: @arduino.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arduino
      @arduino = Arduino.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def arduino_params
      params.fetch(:arduino, {})
    end
end
