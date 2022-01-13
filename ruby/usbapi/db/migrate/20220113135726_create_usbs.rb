# frozen_string_literal: true

class CreateUsbs < ActiveRecord::Migration[7.0]
  def change
    create_table :usbs do |t|
      t.string :label
      t.string :address
      t.string :serialnumber

      t.timestamps
    end
  end
end
