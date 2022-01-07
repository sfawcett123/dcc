if defined?(Sidekiq)
    Sidekiq.configure_server do |config|
      config.on(:startup) do
        #already_scheduled = Sidekiq::ScheduledSet.new.any? {|job| job.klass == "ListusbWorker" }
        ListusbWorker.perform_async # unless already_scheduled
      end
    end
end