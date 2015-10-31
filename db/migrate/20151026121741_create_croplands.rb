class CreateCroplands < ActiveRecord::Migration
  def change
    create_table :croplands do |t|
      t.string :user_id
      t.integer :land_area
      t.string :area_unit
      t.string :land_production
      t.integer :land_output
      t.string :output_unit
      t.integer :output_cycle
      t.datetime :latest_seeding_date
      t.integer :product_id

      t.timestamps
    end
  end
end
