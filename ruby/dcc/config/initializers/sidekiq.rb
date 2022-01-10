Sidekiq.configure_client do |config|
    Rails.application.config.after_initialize do
        ArduinoWorker.perform_in(10.seconds)
    end
end
