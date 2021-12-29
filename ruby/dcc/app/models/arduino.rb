require "libusb"

class Arduino 
    include ActiveModel::Model
    attr_accessor :name, :port

    def persisted?
      false
    end

    class << self
        def all
          dev = []
          usb = LIBUSB::Context.new
          return usb.devices
        end
    end

end
