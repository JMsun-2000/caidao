class AddTransactionPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :transaction_price, :decimal, :precision => 8, :scale => 2
  end
end
