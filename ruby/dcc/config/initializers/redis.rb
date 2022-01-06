require 'redis'

module ReadCache
  class << self
    def redis
      @redis ||= Redis.new(host: "localhost")
    end
  end
end
