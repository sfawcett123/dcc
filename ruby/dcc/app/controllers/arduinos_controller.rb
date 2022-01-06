class ArduinosController < ApplicationController
  layout 'standard'
  
  # GET /arduinos or /arduinos.json
  def index
    logger.info "Reading boards from redis"
    @arduinos = Arduino.boards 

    logger.debug "#{@arduinos}"
    # @data = @arduinos[0].read if @arduinos[0]
  end

end
