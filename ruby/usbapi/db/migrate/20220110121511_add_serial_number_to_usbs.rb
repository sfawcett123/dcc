class AddSerialNumberToUsbs < ActiveRecord::Migration[7.0]
  def change
    add_column :usbs, :serialnumber, :string
  end
end
