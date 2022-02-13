# frozen_string_literal: true

require 'rubyserial'

class SerialPort < Serial

  def initialize(usb)
    @usb = usb
    super(usb.address)
  end

  def read(size = 999_999)
    super(size).chomp!
  end

  def push
    read.each_line do |line|
      puts  line
    end
  rescue NoMethodError
    nil
  end

  private

end
