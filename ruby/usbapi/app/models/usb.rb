# frozen_string_literal: true

class Usb < ApplicationRecord
  attr_accessor :port
  after_initialize :process_device

  private

   def process_device
       self.address = port["address"]     
       self.label = port["label"]     
   end

  def labelled_devices
    @labelled_devices ||= usb.index_by(&:id)
  end

  def fetch(id)
    labelled_devices.fetch(id)
  end
end
