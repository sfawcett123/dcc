# frozen_string_literal: true

class ListusbWorker
  include Sidekiq::Worker

  def perform(*_args)
    logger.info 'Getting list of boards'
    command = 'arduino-cli board list --format json'

    devices = `#{command}`

    JSON.parse(devices).each do |device|
      logger.info "Device Found #{device['port']['address']} "
    end

    already_scheduled = Sidekiq::ScheduledSet.new.any? { |job| job.klass == 'ListusbWorker' }
    logger.info "Already Scheduled #{already_scheduled}"

    ListusbWorker.perform_in(10.seconds) unless already_scheduled
  end
end
