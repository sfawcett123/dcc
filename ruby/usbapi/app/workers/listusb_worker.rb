# frozen_string_literal: true

class ListusbWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
