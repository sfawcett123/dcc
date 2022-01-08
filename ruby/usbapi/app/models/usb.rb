# frozen_string_literal: true

class Usb < ApplicationRecord
  attr_accessor :device

  def initialize(device:)
    self.device = device
  end

  private

  def indexed_devices
      @indexed_devices ||= usb.index_by(&:id)
  end

  def fetch(id)
      indexed_devices.fetch(id)
  end

end
