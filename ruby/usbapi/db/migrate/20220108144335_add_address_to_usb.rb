class AddAddressToUsb < ActiveRecord::Migration[7.0]
  def change
    add_column :usbs, :address, :string
  end
end
