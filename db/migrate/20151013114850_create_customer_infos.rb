class CreateCustomerInfos < ActiveRecord::Migration
  def change
    create_table :customer_infos do |t|
      t.integer :user_id
      t.string :real_name
      t.text :comment_info
      t.integer :phone_number
      t.string :resturant_address
      t.integer :identify_number

      t.timestamps
    end
  end
end
