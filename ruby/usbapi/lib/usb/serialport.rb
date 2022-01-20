# frozen_string_literal: true

require 'rubyserial'
require 'redis'

class SerialPort < Serial
  def initialize(usb, url = 'redis:://localhost:6739')
    @usb = usb
    redis_connect url
    super(usb.address)
  end

  def read(size = 999_999)
    super(size).chomp!
  end

  def push
    read.each_line do |line|
      @redis.lpush @usb.serialnumber, line
    end
  rescue NoMethodError
    nil
  end

  private

  def redis_connect(url)
    uri = URI.parse(url)
    @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
  end
end
