class AddPriorityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :priority, :integer, :default => 0;
  end
end
