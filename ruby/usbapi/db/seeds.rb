# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
roles_list = [
  "Locomotive DCC" 
]

roles_list.each do |name|
  Role.create( role: name )
end
