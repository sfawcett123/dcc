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
       logger.info "Scheduling Arduino Schedule:[#{reschedule( usb )}] Connected:[#{usb.connected}] "
       ReadArduinoJob.set(wait: 10.seconds).perform_later( usb ) if usb.connected and reschedule(usb) 
     end

     # Reschedule if there are no occurances in the queue
     def reschedule( usb )
        queue = Sidekiq::ScheduledSet.new
        queue.each do |job|
             return false  if samejob(job) && sameusb(job , usb) 
        end
        true
     end

     def samejob( job )
       job.args[0]['job_class'] == self.name ? true : false
     end
 
     def sameusb( job , usb )
       job.args[0]['arguments'][0]['_aj_globalid'] == usb.global_id ? true : false
     end 
  end

  private

  def log
    logger.info "Reading Arduino"
  end

end
