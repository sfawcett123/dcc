class AddRoleToArduino < ActiveRecord::Migration[7.0]
  def change
    add_column :arduinos, :role, :string
  end
end
