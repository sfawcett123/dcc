# frozen_string_literal: true

class ArduinosController < ApplicationController
  before_action :set_arduino, only: %i[show edit update destroy]
  before_action :set_title, only_member_actions: true

  # GET /arduinos or /arduinos.json
  def index
    @arduinos = Arduino.all
  end

  # GET /arduinos/1 or /arduinos/1.json
  def show; end

  def set_title
     @page_title = "ARDUINOS"
  end

  # GET /arduinos/new
  def new
    @arduino = Arduino.new
  end

  # GET /arduinos/1/edit
  def edit; end

  # POST /arduinos or /arduinos.json
  def create
    @arduino = Arduino.new(arduino_params)

    respond_to do |format|
      if @arduino.save
        format.html { redirect_to arduino_url(@arduino), notice: 'Arduino was successfully created.' }
        format.json { render :show, status: :created, location: @arduino }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @arduino.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arduinos/1 or /arduinos/1.json
  def update
    respond_to do |format|
      if @arduino.update(arduino_params)
        format.html { redirect_to arduino_url(@arduino), notice: 'Arduino was successfully updated.' }
        format.json { render :show, status: :ok, location: @arduino }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @arduino.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arduinos/1 or /arduinos/1.json
  def destroy
    @arduino.destroy

    respond_to do |format|
      format.html { redirect_to arduinos_url, notice: 'Arduino was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_arduino
    @arduino = Arduino.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def arduino_params
    params.require(:arduino).permit(:serialnumber, :pid, :vid, :fqbn, :name, :role_id)
  end
end
