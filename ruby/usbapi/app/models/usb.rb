# frozen_string_literal: true

class Usb < ApplicationRecord
  def connected?
    @connected
  end

  def global_id
    "gid://usbapi/#{self.class.name}/#{self.id}"
  end

  class << self
    def arduinos
      all.select(&:serialnumber)
    end
  end
end
