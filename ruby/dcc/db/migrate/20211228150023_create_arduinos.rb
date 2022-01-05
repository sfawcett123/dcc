class CreateArduinos < ActiveRecord::Migration[7.0]
  def change
    create_table :arduinos do |t|
      t.string :name
      t.integer :port

      t.timestamps
    end
  end
end
