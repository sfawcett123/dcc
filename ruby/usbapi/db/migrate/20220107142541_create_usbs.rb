class CreateUsbs < ActiveRecord::Migration[7.0]
  def change
    create_table :usbs do |t|

      t.timestamps
    end
  end
end
