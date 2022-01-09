# frozen_string_literal: true

class ListusbWorker
  include Sidekiq::Worker

  def perform(*_args)
    logger.info 'Getting list of boards'
    command = 'arduino-cli board list --format json'

    devices = `#{command}`

    JSON.parse(devices).each do |device|
      Usb.where( :label => device['port']['label'] ).first_or_create do | dev |
           dev.address = device['port']['address']
           dev.label = device['port']['label']
           dev.save()
           logger.info "Device record created #{dev.label}"
      end
    end

    ListusbWorker.perform_in(10.seconds)
  end
end
