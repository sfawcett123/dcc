# frozen_string_literal: true

module UsbsHelper
  ICON = "<i style='color: %s;'class='fa fa-link'></i>"
  CONNECTED = 'green'
  DISCONNECTED = 'red'
  UNAVAILABLE = 'lightgrey'

  def connecticon(usb)
    process_icon(usb).html_safe
  end

  private

  def process_icon(usb)
    usb.serialnumber ? connected(usb) : unavailable_icon
  end

  def connected(usb)
    usb.connected ? connected_icon : disconnected_icon
  end

  def connected_icon
    ICON % CONNECTED
  end

  def disconnected_icon
    ICON % DISCONNECTED
  end

  def unavailable_icon
    ICON % UNAVAILABLE
  end
end
