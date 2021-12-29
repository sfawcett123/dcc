class ArduinosController < ApplicationController
  layout 'standard'
  
  before_action :set_arduino, only: %i[ show edit update destroy ]

  # GET /arduinos or /arduinos.json
  def index
    @arduinos = Arduino.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arduino
      @arduino = Arduino.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def arduino_params
      params.require(:arduino).permit(:name, :port)
    end
end
