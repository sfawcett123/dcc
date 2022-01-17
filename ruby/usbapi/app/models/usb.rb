# frozen_string_literal: true

class Usb < ApplicationRecord
  def connected? 
    @connected 
  end

  class << self
    def arduinos
      all.select(&:serialnumber)
    end
  end
end
