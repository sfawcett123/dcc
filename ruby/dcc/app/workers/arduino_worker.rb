class ArduinoWorker
  include Sidekiq::Worker

  def perform(*args)


    Arduino.destroy

    logger.info "Getting list of boards"

    commandString = "arduino-cli board list --format json"

    devices = %x[ #{commandString} ]

    JSON.parse( devices).each do | device |
      logger.info "Device Found"
      logger.debug "#{device}"
      arduino = Arduino.new( device )
    end

    ArduinoWorker.perform_in(10.seconds)

  end

end
