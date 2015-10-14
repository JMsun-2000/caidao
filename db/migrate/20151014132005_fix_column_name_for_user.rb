class FixColumnNameForUser < ActiveRecord::Migration
  def change
    change_column :users, :priority, :integer, :default => 0;
  end
end
