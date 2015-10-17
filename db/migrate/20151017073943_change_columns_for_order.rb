class ChangeColumnsForOrder < ActiveRecord::Migration
    def change
      rename_column :orders, :address, :delivery_address
      rename_column :orders, :email, :delivery_phone
    end
end
