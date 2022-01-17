# frozen_string_literal: true

class ReadArduinoJob < ApplicationJob
  queue_as :default
  before_perform :log

  def perform( usb )
      schedule if usb.connected 
  end
 
  private

  def log
    logger.info 'Reading Arduino'
  end

  def schedule
    ReadArduinoJob.set(wait: 10.seconds).perform_later
  end

end
