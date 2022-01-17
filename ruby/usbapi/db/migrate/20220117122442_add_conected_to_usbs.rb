class AddConectedToUsbs < ActiveRecord::Migration[7.0]
  def change
    add_column :usbs, :connected, :boolean , :default => false , :null => false
  end
end
