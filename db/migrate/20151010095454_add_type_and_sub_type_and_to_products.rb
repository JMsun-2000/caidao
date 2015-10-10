class AddTypeAndSubTypeAndToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string, :default => '蔬菜'
    add_column :products, :sub_type, :string
  end
end
