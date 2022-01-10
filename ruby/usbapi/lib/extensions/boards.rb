# frozen_string_literal: true

class Boards < OpenStruct
  ARDUINO = '0x2341'
  LIST_BOARDS = 'arduino-cli board list --format json'

  def attached_board?
    defined? port.properties
  end

  def arduino?
    defined? port.properties.vid && (port.properties.vid == ARDUINO)
  end

  class << self
    def all
      devices = `#{LIST_BOARDS}`
      JSON.parse(devices, object_class: Boards)
    end

    def connected
      all.select(&:attached_board?)
    end

    def not_connected?(serialno)
      all.select(&:attached_board?).select { |b| b.port.properties.serialNumber = serialno }.empty?
    end
  end
end
