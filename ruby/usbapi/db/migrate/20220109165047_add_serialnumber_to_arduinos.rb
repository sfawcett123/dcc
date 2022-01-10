class AddSerialnumberToArduinos < ActiveRecord::Migration[7.0]
  def change
    add_column :arduinos, :serialnumber, :string
    add_column :arduinos, :pid, :string
    add_column :arduinos, :vid, :string
    add_column :arduinos, :fqbn, :string
    add_column :arduinos, :name, :string
  end
end
