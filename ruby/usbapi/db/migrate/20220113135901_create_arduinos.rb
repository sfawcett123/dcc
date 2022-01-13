# frozen_string_literal: true

class CreateArduinos < ActiveRecord::Migration[7.0]
  def change
    create_table :arduinos do |t|
      t.string :serialnumber
      t.string :pid
      t.string :vid
      t.string :fqbn
      t.string :name
      t.integer :role_id

      t.timestamps
    end
  end
end
