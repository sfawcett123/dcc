class ArduinosController < ApplicationController
  layout 'standard'
  
  # GET /arduinos or /arduinos.json
  def index
    logger.info "Reading boards from redis"
    @arduinos = Arduino.boards 

    logger.info "Attributes #{@arduinos[0].inspect}"
    # @data = @arduinos[0].read if @arduinos[0]
  end

end
