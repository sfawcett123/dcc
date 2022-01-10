# frozen_string_literal: true

class Usb < ApplicationRecord
  class << self
    def connected
      all.select(&:serialnumber)
    end
end
end
