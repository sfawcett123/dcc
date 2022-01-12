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
    raise_error duplicate_parameter if params.key?(:id) && params.key?(:role)
  end

  def save_arduino
    @arduino.save
  end

  def raise_error(message)
    render json: message, status: 400
  end

  def set_arduino
    @arduino = Arduino.all.select { |b| b.serialnumber = params[:serialnumber] }.first
    raise_error no_data_found if @arduino.nil?
  end

  # Only allow a list of trusted parameters through.
  def arduino_params
    params.permit(:role, :serialnumber)
  end

  def no_data_found
    { error: 'No Arduinos; Plug in an Arduino board', status: 400 }
  end

  def duplicate_parameter
    { error: 'Too many values; Update can only use one parameter', status: 400 }
  end
end
