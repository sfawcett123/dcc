# frozen_string_literal: true

class Usb < ApplicationRecord
  def connected? 
    @serialnumber ? true : false
  end

  class << self
    def connected
      all.select(&:serialnumber)
    end
  end
end
