class AddUnitAndOriginAndInventoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :unit, :string, :default => '公斤'
    add_column :products, :origin, :string, :default => '本地'
    add_column :products, :inventory, :integer, :default => 0
  end
end
