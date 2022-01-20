# frozen_string_literal: true

class RedisController < ApplicationController
  before_action :redis_connect, only: %i[list]
  before_action :set_serial, only: %i[list]

  def list
    @messages = @redis.lrange(@serialnumber, 0, -1)
    @page_title = "Messages from #{@serialnumber}"
  end

  private

  def redis_connect
    uri = URI.parse('redis:://localhost:6739')
    @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
  end

  def set_serial
    @serialnumber = params[:serialnumber]
  end
end
