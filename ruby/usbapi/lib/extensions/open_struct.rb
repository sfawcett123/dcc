# frozen_string_literal: true

class OpenStruct
  ARDUINO = '0x2341'

  def attached_board?
    defined? port.properties
  end

  def arduino?
    return true if defined? port.properties.vid && (port.properties.vid == ARDUINO)

    false
  end
end
