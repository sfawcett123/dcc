# frozen_string_literal: true

class ListusbWorker
  include Sidekiq::Worker

  def perform(*_args)
    connected_devices.each do |device|
         add_usb_device device
         add_board device if device.has_attached_board?
    end
    ListusbWorker.perform_in(10.seconds)
  end
 
  private

  def connected_devices
    command = 'arduino-cli board list --format json'
    devices = `#{command}`
    JSON.parse( devices, object_class: OpenStruct)
  end 

  def add_usb_device( device )
      Usb.where( :label => device.port.label ).first_or_create do | dev |
           dev.address = device.port.address
           dev.label = device.port.label
           dev.save()
           logger.info "Device record created #{dev.label}"
      end
  end

  def add_board( device )
       logger.info "Arduino record being created "
  end

end
