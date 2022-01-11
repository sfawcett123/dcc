# frozen_string_literal: true

class ArduinosController < ApplicationController
  before_action :set_arduino, only: %i[update]
  before_action :check_role, only: %i[update]
  after_action :save_arduino, only: %i[update]

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
  def update
    @arduino.role_id = params[:role]
    render json: @arduino
  end

  private

  def check_role
    logger.info "Checking Role #{params[:role]}"
  end

  def save_arduino
    @arduino.save
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_arduino
    @arduino = Arduino.all.select { |b| b.serialnumber = params[:serialnumber] }.first
  end

  # Only allow a list of trusted parameters through.
  def arduino_params
    params.permit(:role, :serialnumber)
  end
end
