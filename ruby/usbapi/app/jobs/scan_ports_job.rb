# frozen_string_literal: true

class ScanPortsJob < ApplicationJob
  queue_as :default
  before_perform :before_actions
  after_perform  :after_actions

  def perform(*_args)
    record
  end

  private

  def before_actions
    Usb.arduinos.each do |usb|
      remove usb
      schedule_readers usb if usb.connected
    end
  end

  def after_actions
     schedule
  end

  def schedule_readers usb
    ReadArduinoJob.schedule usb 
  end

  def schedule
    ScanPortsJob.set(wait: 10.seconds).perform_later
  end

  def remove usb
      disconnect usb if Boards.not_connected? usb.serialnumber
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

  def disconnect(usb)
    logger.info "Disconnecting #{usb.label}"
    usb.serialnumber = nil
    usb.connected = false
    logger.info "Device disconnected #{usb.label}" if usb.changed?
    usb.save
  end
end
