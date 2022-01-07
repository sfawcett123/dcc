# frozen_string_literal: true

class CreateUsbs < ActiveRecord::Migration[7.0]
  def change
    create_table :usbs, &:timestamps
  end
end
