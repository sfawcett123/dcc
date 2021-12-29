require "libusb"

class Arduino 
    include ActiveModel::Model

    def persisted?
      false
    end

    class << self
        def all
          usb = LIBUSB::Context.new
          return usb.devices(idVendor: 9025)
        end
    end

end
