# frozen_string_literal: true

require 'rubyserial'

class ReadArduinoJob < ApplicationJob
  queue_as :default
  before_perform :log

  def perform( usb )
    ser = Serial.new(usb.address )
    response = ser.read( 1024 )
    response.chomp!
    puts "========================================================="
    puts "#{response}"
    puts "========================================================="

    ReadArduinoJob.schedule usb if usb.connected 
  end

  class << self

     def schedule usb 
       logger.info "Scheduling Arduino [#{reschedule( usb )}]"
       ReadArduinoJob.set(wait: 10.seconds).perform_later( usb ) if reschedule(usb) 
     end

     # Reschedule if there are no occurances in the queue
     def reschedule( usb )
        queue = Sidekiq::Queue.new("default")
        logger.info "#{queue.count} jobs in #{queue.name} queue" 
        queue.each do |job|
             logger.info "Looking at #{job.args[0]['job_class']} == #{self.class.name}"
             return false if job.args[0]['job_class'] == self.class.name
        end
        true
     end
  end

  private

  def log
    logger.info "Reading Arduino"
  end



end
