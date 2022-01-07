# frozen_string_literal: true

class CreateArduinos < ActiveRecord::Migration[7.0]
  def change
    create_table :arduinos, &:timestamps
  end
end
