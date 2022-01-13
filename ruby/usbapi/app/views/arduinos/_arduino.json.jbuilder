# frozen_string_literal: true

json.extract! arduino, :id, :serialnumber, :pid, :vid, :fqbn, :name, :role_id, :created_at, :updated_at
json.url arduino_url(arduino, format: :json)
