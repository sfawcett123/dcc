# frozen_string_literal: true

class ArduinoWorker
  include Sidekiq::Worker

  def perform(*_args)
    USB.destroy

    logger.info 'Getting list of boards'

    command = 'arduino-cli board list --format json'

    devices = `#{command}`

    JSON.parse(devices).each do |device|
      logger.info 'Device Found'
      logger.debug device.to_s
      USB.new(device)
    end

    ArduinoWorker.perform_in(10.seconds)
  end
end
