# frozen_string_literal: true

class Arduino
  def initialize(attributes = {})
    attributes.each { |name, value| process_attributes name, value }
  end

  private

  def process_attributes(name, value)
    case value
    when Hash
      populate_instance_variables value
    when Array
      value.each { |n| populate_instance_variables n }
    else
      create_attribute name, value
    end
  end

  def create_attribute(name, value)
    self.class.send(:attr_accessor, name)
    instance_variable_set("@#{name}", value)
  end
end

class USB
  include ActiveModel::Model

  @vendor = '0x2341'
  @sp = nil

  def initialize(attributes = {})
    @redis = Redis.new(host: 'localhost')
    @logger = Rails.logger
    data = Marshal.dump(attributes)
    @redis.lpush 'arduinos', data
  end

  def open
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE

    @sp = SerialPort.new(@address, baud_rate, data_bits, stop_bits, parity)
  end

  def read
    self.open unless @sp
    @sp.gets
  end

  def write
    puts 'Steev'
  end

  def persisted?
    false
  end

  class << self
    @redis = Redis.new(host: 'localhost')
    @logger = Rails.logger
    def boards
      rval = []

      @logger.info 'Fetching list of arduinos from Redis'
      data = @redis.lrange('arduinos', 0, -1)
      data.each do |row|
        # rubocop:disable Security/MarshalLoad
        popped_row = Marshal.load(row)
        # rubocop:enable Security/MarshalLoad
        rval << Arduino.new(JSON.parse(popped_row.to_json))
      end
      @logger.debug "Redis returns #{rval}"
      rval
    end

    def destroy
      @redis.del('arduinos')
    end
  end
end
