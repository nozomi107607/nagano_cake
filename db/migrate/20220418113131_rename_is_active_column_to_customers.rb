class RenameIsActiveColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :is_active, :is_deleted
  end
end
