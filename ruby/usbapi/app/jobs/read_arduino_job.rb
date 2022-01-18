# frozen_string_literal: true

class ReadArduinoJob < ApplicationJob
  queue_as :default
  before_perform :log

  def perform( usb )
      schedule usb if usb.connected 
  end
 
  private

  def log
    logger.info 'Reading Arduino'
  end

  def schedule usb 
    ReadArduinoJob.set(wait: 10.seconds).perform_later usb
  end

end
