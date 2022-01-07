class CreateArduinos < ActiveRecord::Migration[7.0]
  def change
    create_table :arduinos do |t|

      t.timestamps
    end
  end
end
