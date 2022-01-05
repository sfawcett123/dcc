class ArduinosController < ApplicationController
  layout 'standard'
  
  # GET /arduinos or /arduinos.json
  def index
    Arduino.destroy
    commandString = "arduino-cli board list --format json"
    devices = %x[ #{commandString} ]
    JSON.parse( devices).each do | device |
      @arduino = Arduino.new( device )
    end
    @arduinos = Arduino.boards
    @data = @arduinos[0].read if @arduinos[0]
    puts @data
  end

end
