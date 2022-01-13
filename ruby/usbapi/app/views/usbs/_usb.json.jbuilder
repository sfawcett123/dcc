# frozen_string_literal: true

json.extract! usb, :id, :label, :address, :serialnumber, :created_at, :updated_at
json.url usb_url(usb, format: :json)
