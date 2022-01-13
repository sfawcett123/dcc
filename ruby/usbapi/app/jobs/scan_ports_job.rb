# frozen_string_literal: true

class ScanPortsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    remove
    record
    ScanPortsJob.set( wait: 10.seconds).perform_later
  end

  private

  def remove
    Usb.connected.each do |dev|
      disconnect dev if Boards.not_connected? dev.serialnumber
      logger.info "Device disconnected #{dev.label}" if dev.changed?
    end
  end

  def record
    Boards.connected.each do |device|
      add_usb_device device
      add_board device
    end
  end

  def add_usb_device(device)
    Usb.where(label: device.port.label).first_or_create.tap do |dev|
      dev.address = device.port.address
      dev.label = device.port.label
      dev.serialnumber = device.port.properties.serialNumber
      logger.info "Device record created #{dev.label}" if dev.changed?
      dev.save
    end
  end

  def add_board(device)
    Arduino.where(serialnumber: device.port.properties.serialNumber).first_or_create.tap do |dev|
      dev.serialnumber = device.port.properties.serialNumber
      dev.pid = device.port.properties.pid
      dev.vid = device.port.properties.vid
      dev.fqbn = device.matching_boards.first.fqbn
      dev.name = device.matching_boards.first.name
      logger.info "Arduino record created #{dev.serialnumber}" if dev.changed?
      dev.save
    end
  end

  def disconnect(dev)
    dev.serialnumber = nil
    dev.save
  end
end
