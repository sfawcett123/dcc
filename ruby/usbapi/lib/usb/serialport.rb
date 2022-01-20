# frozen_string_literal: true

require 'rubyserial'

class SerialPort < Serial

  def initialize( usb )
    super( usb.address )
  end 

  def read( size = 999999 )
    super( size ).chomp!
  end

end
