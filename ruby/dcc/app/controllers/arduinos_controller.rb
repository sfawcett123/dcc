class ArduinosController < ApplicationController
  layout 'standard'
  
  before_action :set_arduino, only: %i[ show edit update destroy ]

  # GET /arduinos or /arduinos.json
  def index
    Arduino.destroy
    create()
    @arduinos = Arduino.all
  end

  def create
    commandString = "arduino-cli board list --format json"
    devices = %x[ #{commandString} ]
    JSON.parse( devices).each do | device |
      @arduino = Arduino.new( device )
      puts @arduino
    end
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
