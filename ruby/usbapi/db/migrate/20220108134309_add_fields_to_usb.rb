class AddFieldsToUsb < ActiveRecord::Migration[7.0]
  def change
    add_column :usbs, :label, :string
  end
end
