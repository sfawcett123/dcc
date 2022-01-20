# frozen_string_literal: true

module UsbsHelper
  CONNECT_ICON = "<i style='color: %s;'class='fa fa-link'></i>"
  SERIAL_ICON = "<i style='color: blue;'class='fa fa-database'></i>"
  CONNECTED = 'green'
  DISCONNECTED = 'red'
  UNAVAILABLE = 'lightgrey'

  def connecticon(usb)
    process_icon(usb).html_safe
  end

  def serialnumbericon
    SERIAL_ICON.html_safe
  end

  private

  def process_icon(usb)
    usb.serialnumber ? connected(usb) : unavailable_icon
  end

  def connected(usb)
    usb.connected ? connected_icon : disconnected_icon
  end

  def connected_icon
    CONNECT_ICON % CONNECTED
  end

  def disconnected_icon
    CONNECT_ICON % DISCONNECTED
  end

  def unavailable_icon
    CONNECT_ICON % UNAVAILABLE
  end
end
